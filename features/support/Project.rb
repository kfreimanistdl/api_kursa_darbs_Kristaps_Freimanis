class Project
  attr_accessor :project_id
  attr_accessor :project_name
  attr_accessor :environments
  attr_accessor :collection
  attr_accessor :case
  attr_accessor :steps

  def initialize(project_id, project_name)
    @project_id = project_id
    @project_name = project_name
    @environments = []
    @collection = []
    @case = []
    @steps = []
  end

  def set_project_id(project_id)
    @project_id = project_id
  end

  def add_environment(env)
    @environments.push(env)
  end

  def add_collections(col)
    @collection.push(col)
  end

  def add_cases(cases)
    @case.push(cases)
  end

  def add_steps(step)
    @steps.push(step)
  end

end