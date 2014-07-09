require 'ShipIO'

SHIP_API_KEY = "8g5ruq2s6fqi5f2b0o5r649ipspicqou7"

client = ShipIO::Client.new(SHIP_API_KEY)

SCHEDULER.every '5s' do
  jobs = client.jobs

  passing_num = 0
  running_num = 0
  jobs.each do |job|
    passing_num += 1 if job.builds.first.successful
    running_num += 1 unless (%w(succeeded cancelled stopped failing).include? job.builds.first.state)
  end

  percentage = (passing_num.to_f / jobs.count.to_f) * 100

  puts "Passing: #{passing_num}\nRunning: #{running_num}\nTotal: #{jobs.count}\n\n"

  send_event("jobs", {current: running_num})
  send_event("job_percentage", {current: percentage})
end