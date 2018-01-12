class Environment
  attr_accessor :environment_id
  attr_accessor :environment_name
  attr_accessor :global_variables

  def initialize(environment_id, environment_name)
    @environment_id = environment_id
    @environment_name = environment_name
    @global_variables = []
  end

  def add_global_variables(var)
    @global_variables.push(var)
  end

end