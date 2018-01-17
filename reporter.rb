require 'json'
require_relative 'features/support/api_helper'

build_number = ARGV[0]
link_to_report = ARGV[1]
#passed = ARGV[2]
#failed = ARGV[3]

thumbnail = { 'url' => 'http://1.bp.blogspot.com/-aXHbB9nPPeI/VUZUwaKi8TI/AAAAAAAAAr0/yiXtd5WALPo/s1600/cucumber.png' }
fields = []
fields.push( { 'name' => 'Build number', 'value' => build_number.to_s})
fields.push( { 'name' => 'Link to report', 'value' => link_to_report })
#fields.push( { 'name' => 'Scenarios PASSED', 'value' => passed.to_s })
#fields.push( { 'name' => 'Scenarios FAILED', 'value' => failed.to_s })
embed = []
embed.push({ 'color' => 7725089,
             'fields' => fields,
             'thumbnail' => thumbnail})

payload = { 'content' => 'Kursa_Darbs_API_Kristaps_Freimanis', 
            'embeds' => embed }.to_json

post('https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1',
     headers: { 'Content-Type' => 'application/json' },
     cookies: {},
     payload: payload)