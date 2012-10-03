def y(obj)
  puts obj.to_yaml
end

begin
  require 'wirb'
  Wirb.start
rescue nil
end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

# Alias User[3] for User.find(3) in Rails
if Rails.env
  ActiveRecord::Base.instance_eval { alias :[] :find }
end rescue nil

# ---------------------------------------
#  Local methods for an object
# ---------------------------------------
class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods
    if Rails.env
      (methods - ActiveRecord::Base.methods).sort
    else
      (methods - Object.instance_methods).sort
    end
  end
end

# ----------------------------------------
#  Set IRB prompt to include project name and env (Rails)
#  app_name[development]> or app_name[production]>, etc...
# ----------------------------------------
if Rails.env
  rails_root = File.basename(Dir.pwd)
  prompt = "#{rails_root}[#{Rails.env}]"
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{prompt}> ",
    :PROMPT_S => "#{prompt}* ",
    :PROMPT_C => "#{prompt}? ",
    :RETURN => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS
end rescue nil

