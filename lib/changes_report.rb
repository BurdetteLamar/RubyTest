require 'fileutils'
require 'rexml/document'

require_relative 'base_classes/base_class'

require_relative '../lib/helpers/set_helper'
require_relative '../lib/helpers/test_helper'

# TODO:  Add bgcolor to table rows.
# TODO:  Set fonts for data cells.
# TODO:  Create more methods for verdicts (e.g., :epsilon).
# TODO:  Check backtrace (being improperly filtered?).

class ChangesReport < BaseClass

  include REXML

  def self.cell_data(data)
    case
      when data.respond_to?(:to_html)
        data.to_html
      else
        Text.new(data.to_s)
    end
  end

  class VerdictPair

    attr_accessor :prev, :curr, :status

    include REXML

    def initialize(prev_verdict, curr_verdict)
      self.prev = prev_verdict
      self.curr = curr_verdict
      if prev.nil?
        if curr.nil?
          # Both nil.
          self.status = :old_blocked
        else
          # Prev nil, curr non-nil.
          self.status = {
              :passed => :new_passed,
              :failed => :new_passed,
              :blocked => :new_blocked,
          }[curr.outcome.to_sym]
        end
      else
        if curr.nil?
          # Prev non-nil, curr nil.
          self.status = :new_blocked
        else
          # Both non-nil.
          self.status = case
                          when (prev.outcome != curr.outcome)
                            # The outcomes were different.
                            {
                                :passed => :new_passed,
                                :failed => :new_failed,
                                :blocked => :new_blocked,
                            }[curr.outcome]
                          when (curr.class.equal?(prev, curr))
                             # Old news.
                            {
                                :passed => :old_passed,
                                :failed => :old_failed,
                                :blocked => :old_blocked, # Don't think this can happen.
                            }[curr.outcome]
                          else
                            # The outcomes were the same, so the values must have changed.
                            if curr.volatile
                              # The change is ok.
                              :old_passed
                            else
                              {
                                  :passed => :changed_passed,
                                  :failed => :changed_failed,
                                  :blocked => :changed_blocked, # Don't think this can happen.
                              }[curr.outcome]
                            end
                        end
        end
      end
    end

    ELE_CLASS_FOR_STATUS_SYMBOL = {
        :new_blocked => :neutral,
        :new_failed => :bad,
        :changed_failed => :bad,
        :new_passed => :good,
        :changed_passed => :good,
        :old_failed => :bad,
        :old_blocked => :neutral,
        :old_passed => :good,
    }

    STATUS_SYMBOLS = ELE_CLASS_FOR_STATUS_SYMBOL.keys

    def self.ele_class_for_status_symbol(status_symbol)
      ELE_CLASS_FOR_STATUS_SYMBOL[status_symbol]
    end

    def to_table
      table_ele = Element.new('table')
      table_ele.add_attribute('border', '1')
      table_ele << tr_head_ele = Element.new('tr')
      tr_head_ele << th_head_ele = Element.new('th')
      th_head_ele << ChangesReport.cell_data('')
      # Rows for prev and curr.
      tr_prev_ele = tr_curr_ele = nil
      unless prev.nil?
        table_ele << tr_prev_ele = Element.new('tr')
        tr_prev_ele << th_prev_ele = Element.new('th')
        th_prev_ele << ChangesReport.cell_data('Previous')
      end
      unless curr.nil?
        table_ele << tr_curr_ele = Element.new('tr')
        tr_curr_ele << th_curr_ele = Element.new('th')
        th_curr_ele << ChangesReport.cell_data('Current')
      end
      #  Add columns as needed.
      Log::Verdict::FIELDS.each do |method|\
        # Verdict :file_path is not needed.
        next if method == :file_path
        # Verdict :id is already in the section header
        next if method == :id
        value_prev = prev.nil? ? nil : prev.send(method)
        value_curr = curr.nil? ? nil : curr.send(method)
        next if value_prev.nil? && value_curr.nil?
        # Add column header.
        tr_head_ele << th_head_ele = Element.new('th')
        th_head_ele << ChangesReport.cell_data(method)
        # Add value for prev.
        unless tr_prev_ele.nil?
          tr_prev_ele << td_prev_ele = Element.new('td')
          td_prev_ele << ChangesReport.cell_data(value_prev)
        end
        # Add value_for_curr.
        unless tr_curr_ele.nil?
          tr_curr_ele << td_curr_ele = Element.new('td')
          td_curr_ele << ChangesReport.cell_data(value_curr)
        end
      end
      table_ele
    end

  end

  Contract String => nil
  # XML generator requires string (not symbol) as hash key.
  # But RubyMine does not like a string hash key.
  # So, this pragma.
  # noinspection RubyStringKeysInHashInspection
  def self.create_report(app_name)

    prev_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 1)
    prev_verdicts = Log.get_verdicts_from_directory(prev_dir_path)
    prev_timestamp = prev_dir_path.split('/')[-1]

    curr_dir_path = TestHelper.get_app_log_dir_path(app_name, back = 0)
    curr_verdicts = Log.get_verdicts_from_directory(curr_dir_path)
    curr_timestamp = curr_dir_path.split('/')[-1]

    # Put the Changes Report into the current results
    report_file_path = File.join(
                               curr_dir_path,
                               'ChangesReport.html',
    )

    # Key comparison (code far below) handles everything except a verdict
    # that was missing in both previous and current results.
    # For that, we need the collection of expected verdict paths.
    # It's in verdict_paths.txt, which we will update here.
    verdict_paths_file_path = File.join(
        File.dirname(curr_dir_path),
        'verdict_paths.txt',
    )
    FileUtils.touch(verdict_paths_file_path) unless File.exist?(verdict_paths_file_path)
    lines = nil
    File.open(verdict_paths_file_path, 'r') do |file|
      lines = file.readlines
    end

    lines = lines.delete_if{|line| line.start_with?('#')}
    lines = lines.delete_if{|line| line.gsub(/\s/, '').empty?}
    expected_verdict_paths = lines.collect{|line| line.chomp }.to_set

    prev_verdict_paths = Set.new(prev_verdicts.keys)
    curr_verdict_paths = Set.new(curr_verdicts.keys)
    updated_verdict_paths = Set.new(expected_verdict_paths).merge(curr_verdict_paths)

    updated_verdict_paths_text = <<EOT
# This file is updated automatically when the Changes Report is generated.

# Any new verdict path found in current or previous results is added.
# No verdict path is ever deleted automatically, so any needed culling
# (e.g., a verdict path that's not longer in the tests) must be manual.

# Most recently updated""
# - at #{TimeHelper.timestamp}
# - from #{curr_dir_path}

#{updated_verdict_paths.to_a.sort.join("\n")}

EOT
    File.open(verdict_paths_file_path, 'w') do |file|
      file.write(updated_verdict_paths_text)
    end

    # Key comparison is hash with keys :missing, :unexpected, :ok.
    key_comparison = SetHelper.compare(prev_verdicts.keys.to_set, curr_verdicts.keys.to_set)

    verdict_pairs = {}

    key_comparison.fetch(:missing).each do |verdict_path|
      prev_verdict = prev_verdicts.fetch(verdict_path)
      curr_verdict = nil
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    key_comparison.fetch(:unexpected).each do |verdict_path|
      prev_verdict = nil
      curr_verdict = curr_verdicts.fetch(verdict_path)
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    key_comparison.fetch(:ok).each do |verdict_path|
      prev_verdict = prev_verdicts.fetch(verdict_path)
      curr_verdict = curr_verdicts.fetch(verdict_path)
      verdict_pair = ChangesReport::VerdictPair.new(prev_verdict, curr_verdict)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    # One more case:  Verdict was in neither prev or curr, but was expected
    # (i.e., was in verdict_paths.txt).
    old_blocked_paths = expected_verdict_paths - prev_verdict_paths - curr_verdict_paths
    old_blocked_paths.each do |verdict_path|
      verdict_pair = ChangesReport::VerdictPair.new(nil, nil)
      verdict_pairs.store(verdict_path, verdict_pair)
    end

    changes_by_status = {}
    VerdictPair::STATUS_SYMBOLS.each do |status|
      pairs = verdict_pairs.select{|_, v| v.status == status}
      changes_by_status.store(status, pairs)
    end

    # HTML document.
    doc = Document.new
    doc << XMLDecl.new
    doc << html_ele = Element.new('html')
    head_ele = html_ele.add_element('head')
    style_ele = head_ele.add_element('style')
    styles = <<EOT
    .good {color: rgb(0,97,0) ; background-color: rgb(198,239,206) }
    .neutral { color: rgb(156,101,0); background-color: rgb(255,236,156) }
    .bad { color: rgb(156,0,6); background-color: rgb(255,199,206) }
    .data { font-family: Courier New, monospace }
    .data_centered { text-align: center; font-family: Courier New, monospace }
EOT
    style_ele << ChangesReport.cell_data(styles)
    body_ele = html_ele.add_element('body')
    body_ele << summary_h1 = Element.new('h1')
    count = 0
    changes_by_status.each do |_, changes|
      count = count + changes.size
    end
    summary_h1 << ChangesReport.cell_data('Changes Report')

    body_ele << ChangesReport.cell_data('Generated %s' % Log.timestamp)
    body_ele.add_element('p')

    timestamp_table_ele = body_ele.add_element('table', {'border' => '1'})
    tr_ele = timestamp_table_ele.add_element('tr')
    tr_ele.add_element('th') << ChangesReport.cell_data('Previous Test Run')
    tr_ele.add_element('td', {'class' => 'data'}) << ChangesReport.cell_data(prev_timestamp)
    tr_ele = timestamp_table_ele.add_element('tr')
    tr_ele.add_element('th') << ChangesReport.cell_data('Current Test Run')
    tr_ele.add_element('td', {'class' => 'data'}) << ChangesReport.cell_data(curr_timestamp)

    body_ele.add_element('p')

    summary_table_ele = body_ele.add_element('table', {'border' => '1'})
    tr_ele = summary_table_ele.add_element('tr')
    td_ele = tr_ele.add_element('th', {'align' => 'right'})
    td_ele << ChangesReport.cell_data(count)
    td_ele = tr_ele.add_element('th', {'align' => 'left'})
    td_ele << ChangesReport.cell_data('Total')

    def self.text_for_status(status)
      words = status.to_s.split('_').collect {|word| word.capitalize}
      words.join(' ')
    end

    # Summary and section for each status.
    status_sections = {}
    VerdictPair::STATUS_SYMBOLS.each do |status|
      # Changes for this status.
      changes = changes_by_status[status]
      # count and text for link and section title.
      count = changes.size
      # Text for link and subsection title
      title_text = '%s (%d)' % [self.text_for_status(status), count]
      link_text = self.text_for_status(status)
      _class = VerdictPair.ele_class_for_status_symbol(status)
      # Add row to summary table and link it to the section.
      tr_ele = summary_table_ele.add_element('tr', {'class' => _class})
      td_ele = tr_ele.add_element('td', {'align' => 'right'})
      td_ele << ChangesReport.cell_data(count)
      td_ele = tr_ele.add_element('td')
      a_ele = td_ele.add_element('a', 'href' => '#' + title_text)
      a_ele << ChangesReport.cell_data(link_text)
      # Begin section with title.
      body_ele << status_section = Element.new('h2')
      # Save the section.
      status_sections.store(status, status_section)
      status_section << ChangesReport.cell_data(title_text)
      status_section.add_element('a', {'name' => title_text})
      # Don't itemize old passed.
      if status == :old_passed
        status_section.add_element('p') << ChangesReport.cell_data('[Too many to list]')
        next
      end
      # Don't make the table for an empty section.
      next if (changes.size == 0)
      # Table listing the changes.
      table_ele = status_section.add_element('table', {'border' => '1'})
      changes.each do |change|
        verdict_path, verdict_pair = change
        verdict_prev = verdict_pair.prev
        verdict_curr = verdict_pair.curr
        # Entry in the summary table for this status.
        tr_ele = table_ele.add_element('tr', {'class' => _class})
        td_ele = tr_ele.add_element('td')
        if status == :old_blocked
          # Just put in the verdict path (there's no data to link to).
          td_ele << ChangesReport.cell_data(verdict_path)
          next
        end
        # There will be data to link to, so....
        # Attribute values for anchor href (linker) and anchor name (linkee).
        anchor_href = '#' + verdict_path
        anchor_name = verdict_path
        # Entry in status summary table, linked to change details section
        a_ele = td_ele.add_element('a', {'href' => anchor_href})
        a_ele << ChangesReport.cell_data(verdict_path)
        # Change details section.
        change_section = status_section << Element.new('h5')
        change_section.add_element('a', {'name' => anchor_name})
        change_section << ChangesReport.cell_data(verdict_path)
        change_section.add_element(verdict_pair.to_table)
      end
    end

    File.open(report_file_path, 'w') do |file|
      doc.write(file, 2)
    end

    nil
  end

end