#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Emits Git metadata for use in a Zsh prompt.
#
# AUTHOR:
#    Ben Hoskings
#   https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
#
# MODIFIED:
#    Geoffrey Grosenbach http://peepcode.com

# The methods that get called more than once are memoized.

def git_repo_path
  @git_repo_path ||= `git rev-parse --git-dir 2>/dev/null`.strip
end

def in_git_repo
  !git_repo_path.empty? &&
  git_repo_path != '~' &&
  git_repo_path != "#{ENV['HOME']}/.git"
end

def git_parse_branch
  `git symbolic-ref -q HEAD`.sub(/^refs\/heads\//, '').strip
end

def git_head_commit_id
  `git rev-parse --short HEAD 2>/dev/null`.strip
end

def git_cwd_dirty
  ' 🚧' unless git_repo_path == '.' || `git ls-files -m`.strip.empty?
end

def rebasing_etc
  if File.exists?(File.join(git_repo_path, 'BISECT_LOG'))
    "+bisect"
  elsif File.exists?(File.join(git_repo_path, 'MERGE_HEAD'))
    "+merge"
  elsif %w[rebase rebase-apply rebase-merge ../.dotest].any? {|d| File.exists?(File.join(git_repo_path, d)) }
    "+rebase"
  end
end

if in_git_repo
  print " #{git_parse_branch} #{git_head_commit_id}#{rebasing_etc}#{git_cwd_dirty || ' ✅'}"
end
