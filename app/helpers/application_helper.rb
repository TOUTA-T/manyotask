module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y-%m-%d<br />%H:%M:%S")
  end
end
