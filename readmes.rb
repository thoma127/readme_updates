#!/usr/bin/env ruby

require 'fileutils'
require 'json'

repos = [
  { name: "sdp", url: "https://github.umn.edu/asrweb/sdp", new_url: "https://github.com/umn-asr/sdp", clone: "git@github.umn.edu:asrweb/sdp.git" },
  { name: "asr_ansible", url: "https://github.umn.edu/asrweb/asr_ansible", new_url: "https://github.com/umn-asr/asr_ansible", clone: "git@github.umn.edu:asrweb/asr_ansible.git" },
  { name: "tuition_and_fee_management", url: "https://github.umn.edu/asrweb/tuition_and_fee_management", new_url: "https://github.com/umn-asr/tuition_and_fee_management", clone: "git@github.umn.edu:asrweb/tuition_and_fee_management.git" },
  { name: "roomsearch", url: "https://github.umn.edu/asrweb/roomsearch", new_url: "https://github.com/umn-asr/roomsearch", clone: "git@github.umn.edu:asrweb/roomsearch.git" },
  { name: "academic_calendar", url: "https://github.umn.edu/asrweb/academic_calendar", new_url: "https://github.com/umn-asr/academic_calendar", clone: "git@github.umn.edu:asrweb/academic_calendar.git" },
  { name: "umn_course_fees", url: "https://github.umn.edu/asrweb/umn_course_fees", new_url: "https://github.com/umn-asr/umn_course_fees", clone: "git@github.umn.edu:asrweb/umn_course_fees.git" },
  { name: "ansible-tower", url: "https://github.umn.edu/asrweb/ansible-tower", new_url: "https://github.com/umn-asr/ansible-tower", clone: "git@github.umn.edu:asrweb/ansible-tower.git" },
  { name: "gh_issues", url: "https://github.umn.edu/asrweb/gh_issues", new_url: "https://github.com/umn-asr/gh_issues", clone: "git@github.umn.edu:asrweb/gh_issues.git" },
  { name: "forseti", url: "https://github.umn.edu/asrweb/forseti", new_url: "https://github.com/umn-asr/forseti", clone: "git@github.umn.edu:asrweb/forseti.git" },
  { name: "courses", url: "https://github.umn.edu/asrweb/courses", new_url: "https://github.com/umn-asr/courses", clone: "git@github.umn.edu:asrweb/courses.git" },
  { name: "socket-proxy-builder", url: "https://github.umn.edu/asrweb/socket-proxy-builder", new_url: "https://github.com/umn-asr/socket-proxy-builder", clone: "git@github.umn.edu:asrweb/socket-proxy-builder.git" },
  { name: "oracle_operations", url: "https://github.umn.edu/asrweb/oracle_operations", new_url: "https://github.com/umn-asr/oracle_operations", clone: "git@github.umn.edu:asrweb/oracle_operations.git" },
  { name: "hiring_clearinghouse_review", url: "https://github.umn.edu/asrweb/hiring_clearinghouse_review", new_url: "https://github.com/umn-asr/hiring_clearinghouse_review", clone: "git@github.umn.edu:asrweb/hiring_clearinghouse_review.git" },
  { name: "oracle_cleaner", url: "https://github.umn.edu/asrweb/oracle_cleaner", new_url: "https://github.com/umn-asr/oracle_cleaner", clone: "git@github.umn.edu:asrweb/oracle_cleaner.git" },
  { name: "umn_bootstrap_rails", url: "https://github.umn.edu/asrweb/umn_bootstrap_rails", new_url: "https://github.com/umn-asr/umn_bootstrap_rails", clone: "git@github.umn.edu:asrweb/umn_bootstrap_rails.git" },
  { name: "active_materializer", url: "https://github.umn.edu/asrweb/active_materializer", new_url: "https://github.com/umn-asr/active_materializer", clone: "git@github.umn.edu:asrweb/active_materializer.git" },
  { name: "sdp_models", url: "https://github.umn.edu/asrweb/sdp_models", new_url: "https://github.com/umn-asr/sdp_models", clone: "git@github.umn.edu:asrweb/sdp_models.git" },
  { name: "dars_models", url: "https://github.umn.edu/asrweb/dars_models", new_url: "https://github.com/umn-asr/dars_models", clone: "git@github.umn.edu:asrweb/dars_models.git" },
  { name: "role_manager", url: "https://github.umn.edu/asrweb/role_manager", new_url: "https://github.com/umn-asr/role_manager", clone: "git@github.umn.edu:asrweb/role_manager.git" },
  { name: "ps_models2", url: "https://github.umn.edu/asrweb/ps_models2", new_url: "https://github.com/umn-asr/ps_models2", clone: "git@github.umn.edu:asrweb/ps_models2.git" },
  { name: "ps_models", url: "https://github.umn.edu/asrweb/ps_models", new_url: "https://github.com/umn-asr/ps_models", clone: "git@github.umn.edu:asrweb/ps_models.git" },
  { name: "splunk_config", url: "https://github.umn.edu/asrweb/splunk_config", new_url: "https://github.com/umn-asr/splunk_config", clone: "git@github.umn.edu:asrweb/splunk_config.git" },
  { name: "google_app_scripts_deploy", url: "https://github.umn.edu/asrweb/google_app_scripts_deploy", new_url: "https://github.com/umn-asr/google_app_scripts_deploy", clone: "git@github.umn.edu:asrweb/google_app_scripts_deploy.git" },
  { name: "google_apps_scripts_core", url: "https://github.umn.edu/asrweb/google_apps_scripts_core", new_url: "https://github.com/umn-asr/google_apps_scripts_core", clone: "git@github.umn.edu:asrweb/google_apps_scripts_core.git" },
  { name: "google_form_notifier", url: "https://github.umn.edu/asrweb/google_form_notifier", new_url: "https://github.com/umn-asr/google_form_notifier", clone: "git@github.umn.edu:asrweb/google_form_notifier.git" },
  { name: "sdp_business_objects", url: "https://github.umn.edu/asrweb/sdp_business_objects", new_url: "https://github.com/umn-asr/sdp_business_objects", clone: "git@github.umn.edu:asrweb/sdp_business_objects.git" }
]

repos.each do |repo|
  name = repo[:name]
  clone_url = repo[:clone]
  new_url = repo[:new_url]
  branch_name = "update_readme_with_new_url"
  readme_file = "README.md"
  repo_url = repo[:url]

  repo_info = `gh repo view #{repo_url} --json isArchived --jq .isArchived`
  puts repo_info
  next unless repo_info.strip == "true"

  # Unarchive the repository
  # `gh repo edit #{repo[:url]} --visibility public`
  `gh repo unarchive #{repo[:url]} -y`

  # Clone the repository
  `git clone #{clone_url} #{name}`
  Dir.chdir(name) do
    # Create a new branch
    `git checkout -b #{branch_name}`

    # Add new URL to the top of the README
    if File.exist?(readme_file)
      readme_content = File.read(readme_file)
      File.open(readme_file, 'w') do |file|
        file.puts("**New URL: <a href=\"#{new_url}\">#{new_url}</a>**\n\n#{readme_content}")
      end

      # Stage the README file
      `git add #{readme_file}`

      # Commit the changes
      `git commit -m "Add new URL to README"`

      # Push the new branch to GitHub
      `git push origin #{branch_name}`

      # Create a pull request
      `gh pr create --title "Add new URL to README" --body "This PR updates the README with the new URL." --base main --head #{branch_name}`

      # Merge the pull request
      pr_url = `gh pr view --json url -q .url`.strip
      `gh pr merge #{pr_url} --squash --delete-branch --admin`

      # Archive the repository again
      `gh repo archive #{repo[:url]} -y`
    else
      puts "README.md not found in repository #{name}, skipping."
    end
  end

  # Cleanup: Remove the cloned repository
  FileUtils.rm_rf(name)
end
