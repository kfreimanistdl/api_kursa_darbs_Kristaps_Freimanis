Before() do
  @test_user = User.new('api_kursa_darbs_freimis@mailinator.com', 'Parole!@£')
end

After() do
  delete_environment(@project)
  delete_all_collections(@project)
  delete_all_cases(@project)
end