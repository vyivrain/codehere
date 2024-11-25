require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1m' do
  Project.all.map(&:ping)
end
