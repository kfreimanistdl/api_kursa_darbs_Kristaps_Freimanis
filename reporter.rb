require 'json'
require_relative 'features/support/api_helper'

class Numeric
    def percent_of(n)
      self.to_f / n.to_f * 100
    end
end

report = File.open('report.json').read
report_hash = JSON.parse(report)

total_tests = report_hash[0]['elements'].length
passed_tests = 0
failed_tests = 0

report_hash[0]['elements'].each do |item|
    if item['type'] == 'scenario'
        scenario_passed = true
        item['steps'].each do |step|
            if step['result']['status'] != 'passed'
                scenario_passed = false
            end
        end
        if scenario_passed
            passed_tests += 1
        else
            failed_tests += 1
        end
    end
end

pass_ratio = (passed_tests.percent_of total_tests).to_i
fail_ratio = (failed_tests.percent_of total_tests).to_i

job_name = ARGV[0]
build_number = ARGV[1]
link_to_report = ARGV[2]

thumbnail = { 'url' => 'http://1.bp.blogspot.com/-aXHbB9nPPeI/VUZUwaKi8TI/AAAAAAAAAr0/yiXtd5WALPo/s1600/cucumber.png' }
fields = []
fields.push( { 'name' => 'Job Name', 'value' => job_name})
fields.push( { 'name' => 'Build number', 'value' => build_number.to_s})
fields.push( { 'name' => 'Link to report', 'value' => link_to_report})
fields.push( { 'name' => 'Total tests', 'value' => total_tests.to_s})
fields.push( { 'name' => 'Passed tests', 'value' => passed_tests.to_s})
fields.push( { 'name' => 'Failed tests', 'value' => failed_tests.to_s})
fields.push( { 'name' => 'Passed test ratio', 'value' => pass_ratio.to_s + ' %'})
fields.push( { 'name' => 'Failed test ratio', 'value' => fail_ratio.to_s + ' %'})

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