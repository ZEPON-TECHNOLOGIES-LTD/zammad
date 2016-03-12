# Copyright (C) 2012-2014 Zammad Foundation, http://zammad-foundation.org/

class Overview < ApplicationModel
  store     :condition
  store     :order
  store     :view
  validates :name, presence: true
  validates :prio, presence: true

  before_create :fill_link_on_create, :fill_prio
  before_update :fill_link_on_update

  notify_clients_support
  latest_change_support

  private

  def fill_prio
    return true if prio
    prio = 9999
  end

  def fill_link_on_create
    return true if !link.empty?
    self.link = link_name(name)
  end

  def fill_link_on_update
    return true if link.empty?
    return true if !changes['name']
    self.link = link_name(name)
  end

  def link_name(name)
    link = name.downcase
    link.gsub!(/\s/, '_')
    link.gsub!(/[^0-9a-z]/i, '_')
    link.gsub!(/_+/, '_')
    link
  end

end
