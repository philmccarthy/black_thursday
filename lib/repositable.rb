module Repositable
  def find_by_id(id)
    all.find { |object| object.id == id }
  end

  def find_by_name(name)
    all.find { |object| object.name.downcase == name.downcase}
  end
end
