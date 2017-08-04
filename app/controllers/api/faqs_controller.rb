module Api
  class Faqs # rubocop:disable ClassLength
    def initialize # rubocop:disable MethodLength
      @faqs = []

      add('account', 'Does Strafforts need/store my Strava password?', "
<p>No, Strafforts connects to your Strava account via
Strava's <a href='https://strava.github.io/api/v3/oauth/' target='_blank'>authentication API</a>.</p>
<p>All you need to do is to login to your Strava account then connect Strafforts with Strava.</p>")
      add('account', 'Is it possible to remove all my data on Strafforts?', "
<p>Yes, abusolutely. First make sure you have connected and logged into Strafforts,
then go to your 'Settings' sidebar by clicking <code><i class='fa fa-gears'></i></code> at top right corner of the app,
and choosing <code><i class='fa fa-wrench'></i></code> tab,
then click 'Delete All' button to remove yourself from Strafforts server.</p>
<p>If you've changed your mind,
you can re-connect to give Strafforts permission to retrieve your Strava data again.
However, since all data has been deleted on our server, it might take a while to retrieve everything again.</p>")

      add('best-efforts', 'What are "Estimated Best Efforts"?', "
<p>In short, Strafforts' best efforts are those gold best efforts trophies on Strava running activities,
like <code>Best estimated Half-Marathon effort (1:33:51)</code>, etc.</p>
<p>Every best effort here on Strafforts will have a corresponding gold best efforts trophy on Strava, and vice versa.
This means best efforts are not calculated here on Strafforts, but directly retrieved from Strava.
If an activity on Strava missed out some gold trophies, they won't be shown here either.</p>
<p><img src='https://support.strava.com/attachments/token/UJw9NjMB5AZSqRm8sst8kUqUy/?name=activity+-+Best+Effort.png'
style='width:85%;'></p>
<p>For more details, see
<a href='https://support.strava.com/hc/en-us/articles/216917127-Estimated-Best-Efforts-for-Running' target='_blank'>
What are 'Estimated Best Efforts'?</a> on Strava support forum.</p>")
      add('best-efforts', "Why can't I find some of my best efforts?", "
<p>Best efforts here on Strafforts are just those gold best efforts trophies on Strava running activities.</p>
<p>First please check if the best effort you are looking for do exist on the corresponding Strava activity.
If it does exist on Strava, but not Strafforts, please contact me
(See 'How to contact Strafforts support?' section below).</p>
<p>If it doesn't exist on Strava either, please submit a request at Strava's support site
<a href='https://support.strava.com/hc/en-us/requests/new' target='_blank'>here</a>.</p>
<p><b>Note:</b> Strava's best effort only starts counting from the 2nd best effort of such distance.
See <a href='https://support.strava.com/hc/en-us/articles/216917137-Achievement-Awards-Glossary'>
Achievement Awards Glossary</a> for more details.</p>")
      add('best-efforts', 'Why my activity is shown under another distance?', "
<p>Strafforts' best efforts are just visual representations of those Strava gold best efforts trophies.</p>
<p>If you made a best 20k effort within a full marathon activity,
there will be a gold 20k trophy on this activity on Strava,
therefore Strafforts will pick it up and display it as well.</p>
<p>This means one activity may have multiple best efforts over different distances,
therefore this activity may be shown under different distances in Strafforts.</p>")
      add('best-efforts', "Strava's estimated best efforts can be unreliable, would Strafforts correct them?", "
<p>Unfortunately no.</p>
<p>Even though technically that is totally achievable,
it's against the purpose of having this 'Strava Estimated Best Efforts' visualizer.
This app was designed to fetch and visualize the best efforts data on Strava
(i.e. those trophies actually on activities),
instead of implement an algorithm to calculate athletes' best efforts based on Strava activities.</p>
<p>If one athlete doesn't have '1st best efforts' for 5k distance on Strava, Strafforts shouldn't show it here either.
Because 'Strava Estimated Best Efforts' is a term that was created and defined by Strava,
any data shown in this app should be consistent with such data on Strava.</p>
<p>If someone wants to create an app to analyze something similar,
it would be wise to use another terminology that won't be confused with 'Strava Estimated Best Efforts',
like for example, 'Strava Running PBs'.</p>
<p>However, if you notice some messed up estimated best efforts within Strafforts,
you can try go to those activities on Strava and try
'<a href='https://support.strava.com/hc/en-us/articles/216919597-The-Refresh-My-Achievements-Tool-'
target='_blank'>Refresh Activity Achievements</a>',
or '<a href='https://support.strava.com/hc/en-us/requests/new' target='_blank'>Submit a request</a>'
on Strava support site regarding your wrong Strava best efforts data.</p>
")
      add('best-efforts', 'How to recalculate all best efforts on Strava?', "
<p>The quick answer is - no, you can't.</p>
<p>Sometimes an activity was uploaded as wrong activity type,
which was so fast that created few 1st best efforts trophies.
Then the athlete realized it and changed the activity to something else.
But those 1st best efforts trophies would remain there.
All subsequent best efforts can only be '2nd best efforts'.</p>
<p>In order to solve this problem, Strava provides
'<a href='https://support.strava.com/hc/en-us/articles/216919597-The-Refresh-My-Achievements-Tool-'
target='_blank'>Refresh Activity Achievements</a>' tool in the UI,
which allows users to recalculate the best efforts.</p>
<p>However, the way it was designed is to recalculate best efforts for only this particular activity based on
all activities at the time when this action was taken.
It won't recalculate all best efforts on all activities in a timely fashion.
This means if the athlete realized the situation too late,
that there have 2nd best efforts, 3rd best efforts in other activities uploaded after this activity,
refreshing the achievements will result in nothing.
Because at the refreshing process, Strava will treat the later activities as 1st, 2nd and so on.
But since you are not refreshing those activities, best efforts on those activities won't be updated.</p>
<p>Say for example,</p>
<ul>
<li>Activity ID 11111: 5k 10 minutes, 1st best efforts for 5k</li>
<li>Activity ID 22222: 5k 25 minutes, 2nd best efforts for 5k</li>
<li>Activity ID 33333: 5k 21 minutes, 2nd best efforts for 5k</li>
<li>Activity ID 44444: 5k 23 minutes, 3rd best efforts for 5k</li>
</ul>
<p>Then activity 11111 was refreshed due to wrong activity type,
so there will be no more '1st best efforts' for 5k on this activity.
All other activities will remain the same too, which means there is no more '1st best efforts' on any activities.
If you refresh the achievements of 22222 now, it will become '3rd best efforts for 5k'.
Because Strava recalculates achievements based on all existing activities as of the time refreshing is done,
25 minutes is only the '3rd best efforts for 5k' now. So the athlete would never get '1st best efforts' back.</p>
")

      add('races', 'What are "Races" and how to create them?', "
<p>Strava offers four different sub-categories within the Running activity type to allow
for more detailed and focused analysis of your training.
Those four tags are Run, Race, Long Run, and Workout.</p>
<p>Activties that are tagged as <code>Race</code> will be fetched and analyzed by Strafforts,
then displayed within distance or year view, as well as timeline view.</p>
<p><img src='/screenshots/doc-tag-run-as-race.png' style='width:85%;'></p>
<p>For more details,
see <a href='https://support.strava.com/hc/en-us/articles/216919557-Using-Strava-Run-Type-Tags-to-analyze-your-Runs'
target='_blank'>What are Strava races and how to create them?</a> on Strava support forum.</p>")
      add('races', 'How race distances are determined?', "
<p>Race distance is determined by the actual distance of a Strava activity.
If it's within 2.5% under or 5% over margin of a pre-defined distance (10k for example),
Strafforts will treat it as a 10k race.</p>
<p>If the actual distance of your 10k race is 9.7km or 10.5km,
then Strafforts will put this activity under distance of 'Other'.</p>")
      add('races', 'Why my race is categorized as "Other"?', "
<p>Same as above. Race distance is determined by the actual distance of a Strava activity.
If it's within 2.5% under or 5% over margin of a pre-defined distance (10k for example),
Strafforts will treat it as a 10k race.</p>
<p>If the actual distance of your 10k race is 9.7km or 10.5km,
then Strafforts will put this activity under distance of 'Other'.
</p>")

      add('miscellaneous', 'How to contact Strava support?', "
You can submit a request at Strava's support site
<a href='https://support.strava.com/hc/en-us/requests/new' target='_blank'>here</a>.")
      add('miscellaneous', 'How to contact Strafforts support?', "
<p>Currently Strafforts is a one-man project,
so you can get hold of me via <a href='http://yizeng.me/#contact'>one of these methods</a>.</p>
<p>Alternatively, if you have a GitHub account,
you can also raise an issue <a href='https://github.com/yizeng/strafforts' target='_blank'>here</a>.
</p>")
      add('miscellaneous', 'What technologies are used in Strafforts?', "
<p>See <a href='https://github.com/yizeng/strafforts/blob/master/docs/acknowledgements.md'
target='_blank'>Acknowledgements page</a> for a comprehensive list.</p>")
    end

    def to_json
      @faqs.to_json
    end

    private

    def add(category, title, content)
      faq = { category: category, title: title, content: content }
      @faqs.push(faq)
    end
  end

  class FaqsController < ApplicationController
    def index
      faqs = Faqs.new
      render json: faqs.to_json
    end
  end
end