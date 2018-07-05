class Station
  attr_accessor :name, :line, :division, :latitude, :longitude
  attr_reader :id

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
    new_station = self.new(attributes)
    new_station.save
  end

  def self.all
    station_rows = DB[:conn].execute("SELECT * FROM stations")
    # we need to create instances
    station_rows.map do |station_row|
      self.send(:new_from_row, station_row)
    end
  end

  def self.find(id)
    station_row = DB[:conn].execute("SELECT * FROM stations WHERE id = ?", id)[0]
    if station_row
      self.send(:new_from_row, station_row)
    end
  end

  def self.find_by(attributes)
    conditions = conditions_from_hash(attributes)
    values = attributes.values
    sql = <<-SQL
      SELECT * from stations
      WHERE #{conditions}
    SQL
    station_row = DB[:conn].execute(sql, *values)[0]
    if station_row
      self.send(:new_from_row, station_row)
    end
  end

  def self.delete(id)
    station = self.find(id)
    station.delete
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
    sql = <<-ANYTHING
      INSERT INTO stations (name, line, division, latitude, longitude)
      VALUES (?, ?, ?, ?, ?)
    ANYTHING

    DB[:conn].execute(sql, self.name, self.line, self.division, self.latitude, self.longitude)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM stations")[0][0]
    self
  end

  def update_record
    sql = <<-SQL
      UPDATE stations
      SET name = ?, line = ?, division = ?, latitude = ?, longitude = ?
      WHERE id = ?
    SQL

    DB[:conn].execute(sql, self.name, self.line, self.division, self.latitude, self.longitude, self.id)
    self
  end

  def delete_record
    sql = <<-SQL
      DELETE FROM stations
      WHERE id = ?
    SQL

    DB[:conn].execute(sql, self.id)
    @id = nil
    self
  end

  def self.new_from_row(station_row)
    station = self.new(station_row)
    station.instance_variable_set(:@id, station_row["id"])
    station
  end

  def self.conditions_from_hash(attributes)
    attributes.inject([]) do |acc, (k,v)|
      acc.push("#{k} = ?")
    end.join(" AND ")
  end
end
