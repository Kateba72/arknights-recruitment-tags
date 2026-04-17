#! /usr/bin/env ruby

require 'date'

TAGS = [
  VANG = 'Vanguard',
  GUAR = 'Guard',
  DEFR = 'Defender',
  SNIP = 'Sniper',
  CAST = 'Caster',
  MEDC = 'Medic',
  SUPP = 'Supporter',
  SPEC = 'Specialist',
  MELEE = 'Melee',
  RANGD = 'Ranged',
  AOE = 'AoE',
  CCL = 'Crowd-Control',
  DPR = 'DP-Recovery',
  DPS = 'DPS',
  DBF = 'Debuff',
  DEF = 'Defense',
  ELE = 'Elemental',
  FRD = 'Fast-Redeploy',
  HEA = 'Healing',
  NUK = 'Nuker',
  ROB = 'Robot',
  SHF = 'Shift',
  SLO = 'Slow',
  SMN = 'Summon',
  SUP = 'Support',
  SRV = 'Survival',
].freeze

MAX_SELECTABLE_TAGS = 3

class Operator
  attr_reader :rarity, :tags

  def initialize(rarity, cls, *tags)
    @rarity = rarity

    unless tags.include?(MELEE) || tags.include?( RANGD)
      if [VANG, GUAR, DEFR, SPEC].include? cls
        tags << MELEE
      else
        tags << RANGD
      end
    end

    tags << cls

    @tags = tags.sort
  end
end

OPERATORS = [
  Operator.new(3, VANG, DPR), # 3*Fang, 3*Vanilla
  Operator.new(3, VANG, DPR, DPS), # 3*Plume, (4*Scavenger, 4*Vigna, 5*Chiave, 5*Reed)
  Operator.new(4, VANG, DPR, HEA), # 4*Myrtle
  Operator.new(4, VANG, RANGD, DPR, SMN), # 4*Beanstalk
  Operator.new(5, VANG, DPR, SUP), # 5*Elysium, 5*Zima
  Operator.new(5, VANG, CCL, DPR), # 5*Texas

#  Operator.new(1, GUAR, ROB, SUP), # Castle-3
  Operator.new(3, GUAR, DPS, SRV), # 3*Melantha (4*Matoimaru, 4*Utage, 5*Indra, 5*Akafuyu)
  Operator.new(3, GUAR, DPS), # 3*Midnight (4*Arene, 4*Beehunter, 4*Jackie, 4*Mousse, 5*Flint)
  Operator.new(3, GUAR, AOE, SRV), # 3*Popukar (4*Estelle, 5*Broca, 5*Specter)
  Operator.new(4, GUAR, DPS, NUK), # 4*Cutter
  Operator.new(4, GUAR, DPS, SUP), # 4*Dobermann (5*Swire)
  Operator.new(4, GUAR, DPS, SLO), # 4*Frostleaf
  Operator.new(5, GUAR, DPS, DEF), # 5*Astesia
  Operator.new(5, GUAR, AOE, DPS), # 5*Ayerscarpe

#  Operator.new(1, DEFR, DEF, ROB), # Friston-3
  Operator.new(3, DEFR, DEF), # 3*Beagle (4*Bubble, 4*Cuora, 4*Matterhorn)
  Operator.new(3, DEFR, DEF, HEA), # 3*Spot (4*Gummy, 5*Hung, 5*Nearl)
  Operator.new(5, DEFR, DPS, DEF), # 5*Asbestos, 5*Liskarm
  Operator.new(5, DEFR, DEF, SHF), # 5*Croissant
  Operator.new(5, DEFR, DPS, DEF, SRV), # 5*Vulcan

#  Operator.new(1, SNIP, ROB, SUP), # 'Justice Knight'
  Operator.new(3, SNIP, DPS), # 3*Adnachiel, 3*Kroos (4*Aciddrop, 4*Vermeil, 5*April, 5*Blue Poison, 5*GreyThroat, 5*Platinum, 5*Provence, 5*Toddifons)
  Operator.new(3, SNIP, AOE), # 3*Catapult (5*Aosta, 5*Executor)
  Operator.new(4, SNIP, DPS, SLO), # 4*Ambriel, 4*May (5*Andreana)
  Operator.new(4, SNIP, DPS, SRV), # 4*Jessica
  Operator.new(4, SNIP, DPS, DBF), # 4*Meteor
  Operator.new(4, SNIP, AOE, DPS), # 4*Pinecone
  Operator.new(4, SNIP, AOE, SLO), # 4*Shirayuki
  Operator.new(5, SNIP, DPS, NUK), # 5*Firewatch
  Operator.new(5, SNIP, AOE, DBF), # 5*Meteorite, 5*Sesa

  Operator.new(3, CAST, AOE), # 3*Lava (4*Gitano)
  Operator.new(3, CAST, DPS), # 3*Steward (5*Leizi, 5*Iris)
  Operator.new(4, CAST, CCL, DPS), # 4*Click
  Operator.new(4, CAST, AOE, SLO), # 4*Greyy
  Operator.new(4, CAST, DPS, DBF), # 4*Haze
  Operator.new(5, CAST, AOE, DEF), # 5*Beeswax
  Operator.new(5, CAST, AOE, NUK), # 5*Leonhardt
  Operator.new(5, CAST, DPS, HEA, SLO), # 5*Nightmare

#  Operator.new(1, MEDC, HEA, ROB), # Lancet-2
  Operator.new(3, MEDC, HEA), # 3*Ansel, 3*Hibiscus (4*Myrrh, 4*Perfumer, 4*Sussuro, 5*Silence, 5*Whisperain)
  Operator.new(4, MEDC, HEA, SUP), # 4*Purestream (5*Ptilopsis, 5*Warfarin)

#  Operator.new(1, SUPP, ELE, ROB), # PhonoR-0
  Operator.new(3, SUPP, SLO), # 3*Orchid (4*Earthspirit)
  Operator.new(4, SUPP, HEA, SLO), # 4*Podenco
  Operator.new(5, SUPP, CCL, SLO), # 5*Glaucus
  Operator.new(5, SUPP, DPS, SLO), # 5*Istina
  Operator.new(5, SUPP, CCL, SMN), # 5*Mayer
  Operator.new(5, SUPP, DBF), # 5*Pramanix, 5*Shamare
  Operator.new(5, SUPP, SUP, SRV), # 5*Tsukinogi

#  Operator.new(1, SPEC, NUK, ROB), # THRM-EX
  Operator.new(4, SPEC, DEF, FRD), # 4*Gravel
  Operator.new(4, SPEC, DPS, FRD), # 4*Jaye (5*Mr. Nothing)
  Operator.new(4, SPEC, SHF), # 4*Rope, 4*Shaw
  Operator.new(5, SPEC, DPS, SHF), # 5*Cliffheart
  Operator.new(5, SPEC, SHF, SLO), # 5*FEater
  Operator.new(5, SPEC, CCL, FRD), # 5*Kafka, 5*Project Red
  Operator.new(5, SPEC, DPS, SRV), # 5*Manticore
  Operator.new(5, SPEC, DBF, FRD), # 5*Waai Fu
].freeze

def all_combinations
  @all_combinations ||= begin
    combinations = {}
    OPERATORS.each do |operator|
      (1..MAX_SELECTABLE_TAGS).each do |combination_length|
        operator.tags.combination(combination_length).each do |tags|
          combinations[tags] = operator.rarity unless combinations[tags]&.<= operator.rarity
        end
      end
    end

    combinations
  end
end

def combinations_by_rarity
  @combinations_by_rarity ||= begin
    by_rarity = {}
    all_combinations.each do |tags, rarity|
      by_rarity[rarity] ||= []
      by_rarity[rarity] << tags
    end

    by_rarity.transform_values { |c| filter_combinations(c) }
  end
end

def filter_combinations(combinations)
  combinations.delete_if do |tags|
    (1...tags.size).any? do |subcombination_size|
      tags.combination(subcombination_size).any? { |c| combinations.include? c }
    end
  end
end

OUTPUT_ORDER = [FRD, SMN, CCL, DBF, SUP, NUK, SHF, SPEC, SLO, HEA, SRV, DPS, DEF, RANGD].freeze
OutputLine = Struct.new(:tag, :rarity, :combinations) do
  def to_s
    out = +'  '
    out << color(tag, rarity)

    combination_output = combinations[4].sort_by(&:size).map { color(_1.join('+'), 4) } +
      combinations[5].sort_by(&:size).map { color(_1.join('+'), 5) }
    out << ' + ' if combination_output.size > 0
    out << combination_output.join(', ')

    out
  end
end

def color(text, rarity)
  return '' unless text.size > 0
  "\e[3#{{3 => '4', 4 => '5', 5 => '3'}[rarity]}m#{text}\e[0m"
end

def needed_recruitment_vouchers
  now = Time.now.utc

  next_monthly_reset = if now.month == 12
    Time.utc(now.year + 1, 1, 1, 11, 0, 0)
  else
    Time.utc(now.year, now.month + 1, 1, 11, 0, 0)
  end

  remaining_days = ((next_monthly_reset - now) / (60 * 60 * 24)).to_i

  next_monday_candidate = Time.utc(now.year, now.month, now.day, 11, 0, 0)
  next_monday_candidate += 60 * 60 * 24 if now >= next_monday_candidate
  next_monday_candidate += 60 * 60 * 24 until next_monday_candidate.wday == 1

  remaining_mondays = ((next_monthly_reset - next_monday_candidate) / (60 * 60 * 24 * 7)).ceil
  additional_weekly_vouchers = remaining_mondays * 10

  puts "Keep at least #{remaining_days * 3 - additional_weekly_vouchers} recruitment vouchers (assuming 3 recruitments daily)"
end

output = OUTPUT_ORDER.to_h { |tag| [tag, OutputLine.new(tag, 3, { 4 => [], 5 => [] })] }
[4, 5].each do |rarity|
  combinations_by_rarity[rarity].each do |combination|
    if combination.size > 1
      in_output_order = OUTPUT_ORDER.find { |tag| combination.include? tag }
      raise "No output found for #{combination} (#{rarity}*)" unless in_output_order
      output[in_output_order].combinations[rarity] << combination - [in_output_order]
    else
      tag = combination.first
      raise "Single tag #{tag} (#{rarity}*) is not in output order" unless OUTPUT_ORDER.include? tag
      output[tag].rarity = rarity
    end
  end
end

puts
puts output.values.map(&:to_s).join("\n")
puts
needed_recruitment_vouchers
