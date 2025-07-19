#! /usr/bin/env ruby

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
  Operator.new(3, VANG, DPR), # Fang, Vanilla
  Operator.new(3, VANG, DPR, DPS), # Plume, (Scavenger, Vigna, Chiave, Reed)
  Operator.new(4, VANG, DPR, HEA), # Myrtle
  Operator.new(4, VANG, RANGD, DPR, SMN), # Beanstalk
  Operator.new(5, VANG, DPR, SUP), # Elysium, Zima
  Operator.new(5, VANG, CCL, DPR), # Texas

#  Operator.new(1, GUAR, ROB, SUP), # Castle-3
  Operator.new(3, GUAR, DPS, SRV), # Melantha (Matoimaru, Utage, Indra)
  Operator.new(3, GUAR, DPS), # Midnight (Arene, Beehunter, Jackie, Mousse, Flint)
  Operator.new(3, GUAR, AOE, SRV), # Popukar (Estelle, Broca, Specter)
  Operator.new(4, GUAR, DPS, NUK), # Cutter
  Operator.new(4, GUAR, DPS, SUP), # Dobermann (Swire)
  Operator.new(4, GUAR, DPS, SLO), # Frostleaf
  Operator.new(5, GUAR, DPS, DEF), # Astesia
  Operator.new(5, GUAR, AOE, DPS), # Ayerscarpe

#  Operator.new(1, DEFR, DEF, ROB), # Friston-3
  Operator.new(3, DEFR, DEF), # Beagle (Bubble, Cuora, Matterhorn)
  Operator.new(3, DEFR, DEF, HEA), # Spot (Gummy, Hung, Nearl)
  Operator.new(5, DEFR, DPS, DEF), # Asbestos, Liskarm
  Operator.new(5, DEFR, DEF, SHF), # Croissant
  Operator.new(5, DEFR, DPS, DEF, SRV), # Vulcan

#  Operator.new(1, SNIP, ROB, SUP), # 'Justice Knight'
  Operator.new(3, SNIP, DPS), # Adnachiel, Kroos (Aciddrop, Vermeil, April, Blue Poison, GreyThroat, Platinum, Provence)
  Operator.new(3, SNIP, AOE), # Catapult (Aosta, Executor)
  Operator.new(4, SNIP, DPS, SLO), # Ambriel, May (Andreana)
  Operator.new(4, SNIP, DPS, SRV), # Jessica
  Operator.new(4, SNIP, DPS, DBF), # Meteor
  Operator.new(4, SNIP, AOE, DPS), # Pinecone
  Operator.new(4, SNIP, AOE, SLO), # Shirayuki
  Operator.new(5, SNIP, DPS, NUK), # Firewatch
  Operator.new(5, SNIP, AOE, DBF), # Meteorite, Sesa

  Operator.new(3, CAST, AOE), # Lava (Gitano)
  Operator.new(3, CAST, DPS), # Steward (Leizi, Iris)
  Operator.new(4, CAST, CCL, DPS), # Click
  Operator.new(4, CAST, AOE, SLO), # Greyy
  Operator.new(4, CAST, DPS, DBF), # Haze
  Operator.new(5, CAST, AOE, DEF), # Beeswax
  Operator.new(5, CAST, AOE, NUK), # Leonhardt
  Operator.new(5, CAST, DPS, HEA, SLO), # Nightmare

#  Operator.new(1, MEDC, HEA, ROB), # Lancet-2
  Operator.new(3, MEDC, HEA), # Ansel, Hibiscus (Myrrh, Perfumer, Sussuro, Silence)
  Operator.new(4, MEDC, HEA, SUP), # Purestream (Ptilopsis, Warfarin)

#  Operator.new(1, SUPP, ELE, ROB), # PhonoR-0
  Operator.new(3, SUPP, SLO), # Orchid (Earthspirit)
  Operator.new(4, SUPP, HEA, SLO), # Podenco
  Operator.new(5, SUPP, CCL, SLO), # Glaucus
  Operator.new(5, SUPP, DPS, SLO), # Istina
  Operator.new(5, SUPP, CCL, SMN), # Mayer
  Operator.new(5, SUPP, DBF), # Pramanix, Shamare
  Operator.new(5, SUPP, SUP, SRV), # Tsukinogi

#  Operator.new(1, SPEC, NUK, ROB), # THRM-EX
  Operator.new(4, SPEC, DEF, FRD), # Gravel
  Operator.new(4, SPEC, DPS, FRD), # Jaye
  Operator.new(4, SPEC, SHF), # Rope, Shaw
  Operator.new(5, SPEC, DPS, SHF), # Cliffheart
  Operator.new(5, SPEC, SHF, SLO), # FEater
  Operator.new(5, SPEC, CCL, FRD), # Kafka, Project Red
  Operator.new(5, SPEC, DPS, SRV), # Manticore
  Operator.new(5, SPEC, DBF, FRD), # Waai Fu
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

OUTPUT_ORDER = [FRD, CCL, DBF, SUP, NUK, SHF, SPEC, SMN, SLO, HEA, SRV, DPS, DEF, RANGD].freeze
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
