require 'rest-client'
require 'test-unit'

def create_new_collection(name)
  collection_payload = { name: name,
                         description: 'collection_description' + Time.now.to_s }.to_json

  response = post('http://apimation.com/collections',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: collection_payload)

  assert_equal(200, response.code, "Couldn't create new collection! Response : #{response}")
  response_hash = JSON.parse(response)
  collection = Collection.new(response_hash['id'], response_hash['name'])
  assert_equal(collection.collection_name, response_hash['name'], "Incorrect collection!")
  collection
end

def delete_all_collections(project)
  project.collection.each do | item |
    response_delete = delete('http://apimation.com/collections/' + item.collection_id,
                           headers: {},
                           cookies: @test_user.session_cookie)
    assert_equal(204, response_delete.code, "Can't delete environment! Response : #{response_delete}")
  end
  
end