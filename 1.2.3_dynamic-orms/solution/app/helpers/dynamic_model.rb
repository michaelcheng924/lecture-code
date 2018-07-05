class DynamicModel
  attr_reader :id

  def self.inherited(childclass)
    childclass.column_names.each do |column_name|
      attr_accessor column_name.to_sym
    end
  end

  def initialize(attributes)
    @id = nil
    self.send(:mass_assign_attributes, attributes)
  end

  def save
    self.id.nil? ? self.send(:insert_record) : self.send(:update_record)
  end

  def update(attributes)
    self.send(:mass_assign_attributes, attributes)
    self.save
  end

  def delete
    self.send(:delete_record)
  end

  def self.create(attributes)
    new_instance = self.new(attributes)
    new_instance.save
  end

  def self.all
    rows = DB[:conn].execute("SELECT * FROM #{self.table_name}")
    # we need to create instances
    rows.map do |row|
      self.send(:new_from_row, row)
    end
  end

  def self.table_name
    self.to_s.downcase + "s"
  end

  def self.find(id)
    row = DB[:conn].execute("SELECT * FROM #{self.table_name} WHERE id = ?", id)[0]
    if row
      self.send(:new_from_row, row)
    end
  end

  def self.find_by(attributes)
    conditions = conditions_from_hash(attributes)
    values = attributes.values
    sql = <<-SQL
      SELECT * from #{self.table_name}
      WHERE #{conditions}
    SQL
    row = DB[:conn].execute(sql, *values)[0]
    if row
      self.send(:new_from_row, row)
    end
  end

  def self.delete(id)
    instance = self.find(id)
    instance.delete
  end

  def self.column_names
    sql = <<-SQL
    PRAGMA table_info(#{self.table_name})
    SQL

    columns = DB[:conn].execute(sql).map do |hsh|
      hsh["name"]
    end
    
    columns.delete("id")

    columns
  end

  private

  def mass_assign_attributes(attributes)
    attributes.each do |k, v|
      setter_method = "#{k}="
      if self.respond_to?(setter_method)
        self.send(setter_method, v)
      end
    end
  end

  def insert_record
    values = self.class.column_names.map do |name|
      self.send(name.to_sym)
    end
    question_marks = self.class.column_names.map { "?" }.join(", ")

    sql = <<-ANYTHING
      INSERT INTO #{self.class.table_name} (#{self.class.column_names.join(", ")})
      VALUES (#{question_marks})
    ANYTHING

    DB[:conn].execute(sql, *values)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")[0][0]
    self
  end

  def update_record
    values = self.class.column_names.map do |column_name|
      self.send(column_name.to_sym)
    end

    question_marks = self.class.column_names.map do |column_name|
      "#{column_name} = ?"
    end
    
    sql = <<-SQL
      UPDATE #{self.class.table_name}
      SET #{question_marks}
      WHERE id = ?
    SQL

    DB[:conn].execute(sql, *values, self.id)
    self
  end

  def delete_record
    sql = <<-SQL
      DELETE FROM #{self.class.table_name}
      WHERE id = ?
    SQL

    DB[:conn].execute(sql, self.id)
    @id = nil
    self
  end

  def self.new_from_row(row)
    instance = self.new(row)
    instance.instance_variable_set(:@id, row["id"])
    instance
  end

  def self.conditions_from_hash(attributes)
    attributes.inject([]) do |acc, (k,v)|
      acc.push("#{k} = ?")
    end.join(" AND ")
  end
end