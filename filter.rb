#!/usr/bin/env ruby -Ku
# -*- coding: utf-8 -*-
Plugin.create(:filter) do
  UserConfig[:filter_mute_kind_client] ||= []
  UserConfig[:filter_mute_word] ||= []

  filter_show_filter do |msgs|
    mute_words = UserConfig[:filter_mute_kind_client].select{|m|!m.empty?}
    if mute_words
      msgs = msgs.select{ |m|
        not UserConfig[:filter_mute_kind_client].any?{ |word|
          word.to_s.include?(m[:source]) if m[:source] != nil
        }
      }
    end
    [msgs]
  end

  filter_show_filter do |msgs|
    mute_words = UserConfig[:filter_mute_word].select{|m|!m.empty?}
    if mute_words
      msgs = msgs.select{ |m|
        not mute_words.any?{ |word|
          m.to_s.include?(word)
        }
      }
    end
    [msgs]
  end

  settings "ミュート" do
    settings "ミュートする" do
      multi "ユーザ", :muted_users
      multi "クライアント", :filter_mute_kind_client
      multi "単語", :filter_mute_word
    end
  end

end
