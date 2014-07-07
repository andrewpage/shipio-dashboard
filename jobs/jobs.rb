SCHEDULER.every '10s' do
  new_num = rand(15)
  send_event('jobs', current: new_num)
end

SCHEDULER.every '5s' do
	passing_jobs = 10
	failing_jobs = rand(5)

	percentage = (passing_jobs.to_f / (passing_jobs + failing_jobs).to_f) * 100

	send_event('job_percentage', current: percentage.round(1))
end