require 'fileutils'
require 'date'
# module for handling files
module FileHelper
  def create_file(path, extension, message)
    dir = File.dirname(path)
    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end
    path << ".#{extension}"
    File.open(path, 'w')  {|f| f.write(message) }
  end

  def generate_custom_message(first_name, last_name)
    msg = "Dear #{first_name} #{last_name}, \n"\
    'you have successfully '\
    'registered on ASENTUS Micro learning app. \n Your instructor will have to approve this '\
    'and you can start learning'
    d = DateTime.now
    y = d.strftime("%d%m%Y%H%M%S")
    file_name = first_name + '_' + last_name + '_' + y
    create_file('public/uploads/'+file_name, 'txt', msg)
    file_name + '.txt'
  end
end
