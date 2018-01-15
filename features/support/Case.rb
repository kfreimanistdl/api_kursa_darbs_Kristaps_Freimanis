class Case
    attr_accessor :case_id
    attr_accessor :case_name
    attr_accessor :case_description
  
    def initialize(case_id, case_name, case_description)
      @case_id = case_id
      @case_name = case_name
      @case_description = case_description
    end
  
  end