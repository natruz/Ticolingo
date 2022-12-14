//
//  S2.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

// The default difficulties to use, in case they need to be bulk modified.
let S2Difficulty = 2
let S2HCLDifficulty = 3

// Vocab init:
/*
Vocab(term: "",
      definition: "",
      exampleSentences: ["", ""],
      difficulty: S2Difficulty),
 */

let S2StudySet = StudySetGroup(name: "Secondary 2", sets: [
    StudySet(title: "Chapter 1", terms: [
        Vocab(term: "犹豫",
              definition: "\(adj) Hesitate",
              exampleSentences: ["他犹豫了一下才回答", "时间不多，不要在犹豫了"],
              difficulty: S2Difficulty),
        Vocab(term: "叛逆",
              definition: "\(verb) Rebel against, \(adj) Rebellious, \(noun) Rebel",
              exampleSentences: ["他受他的孩子越耐越叛逆", "你长大时候不能那么叛逆"],
              difficulty: S2Difficulty),
        Vocab(term: "委屈",
              definition: "\(adj) Feel wronged",
              exampleSentences: ["爸爸说我打破了桌子，我感的很委屈", "听了朋友的话，我委屈无奈"],
              difficulty: S2Difficulty),
        Vocab(term: "内疚",
              definition: "\(adj) Feel guilty, be conscience-stricken",
              exampleSentences: ["我打破了我的杯子，没高数妈妈，感的很内疚", "我偷了同学的笔，感非常内疚"],
              difficulty: S2Difficulty),
        Vocab(term: "不妨",
              definition: "\(advb) There is no harm in, might as well",
              exampleSentences: ["你不妨跟他谈一谈", "我不放现在就告诉他"],
              difficulty: S2Difficulty-1),
        Vocab(term: "刀子嘴，豆腐心",
              definition: "\(idiom) Sharp words, tofu (soft) heart",
              exampleSentence: "你的妈妈刀的嘴，豆腐心，说的话都是为你好。",
              difficulty: S2Difficulty),
        Vocab(term: "匿名",
              definition: "\(verb) Not revealing one's name, Anonymous, \(noun) Anonymous",
              exampleSentences: ["昨天，他收到了一封匿名信"],
              difficulty: S2Difficulty),
        Vocab(term: "监督",
              definition: "\(verb) Supervise, \(noun) Supervisor",
              exampleSentence: "爸爸天天监督我，不让我跟朋友去玩",
              difficulty: S2Difficulty),
        Vocab(term: "疏远",
              definition: "\(verb) Drift away, eg. of relationships",
              exampleSentences: ["他这样就疏远了自己的朋友", "两人关系越来越疏远"],
              difficulty: S2Difficulty),
        Vocab(term: "迎刃而解",
              definition: "\(idiom) (of a problem) be readily solved, like bamboo splitting when it meets a knife",
              exampleSentence: "抓住了这个主要矛盾，一切问题就迎刃而解了",
              difficulty: S2Difficulty),
        Vocab(term: "崇拜",
              definition: "\(verb) Worship, adore, idolise",
              exampleSentences: ["他很崇拜他父亲", "青少年不要盲目崇拜某些“明星“"],
              difficulty: S2Difficulty),
        Vocab(term: "抽屉",
              definition: "\(noun) Drawer, cabinet",
              exampleSentences: ["我不能打开这个抽屉，你可以帮助我吗？", "把抽屉腾空"],
              difficulty: S2Difficulty),
        Vocab(term: "精疲力竭",
              definition: "\(idiom) exhausted, worn out",
              exampleSentence: "今天考完了两个考试，我精疲力竭了",
              difficulty: S2Difficulty),
        Vocab(term: "衰老",
              definition: "\(adj) old and feeble",
              exampleSentences: ["奶奶看起来比去年衰老了许多", "大自然不会一日衰老"],
              difficulty: S2Difficulty),
        Vocab(term: "抑郁",
              definition: "\(adj) depressed, gloomy",
              exampleSentences: ["他今天很抑郁", "抑郁不平"],
              difficulty: S2Difficulty),
        Vocab(term: "寂寞",
              definition: "\(adj) lonely",
              exampleSentence: "在学校里，我有很多朋友，一点也不寂寞",
              difficulty: S2Difficulty),
        Vocab(term: "启齿",
              definition: "\(verb) open one's mouth, start to talk",
              exampleSentence: "这件事情让我觉得难以启齿",
              difficulty: S2Difficulty),
        Vocab(term: "懊恼",
              definition: "\(adj) annoyed, vexed, upset",
              exampleSentences: ["他考了不好，信了很懊恼", "由于她丢失了钱包，因此感到懊恼"],
              difficulty: S2Difficulty),
        Vocab(term: "伺机",
              definition: "\(verb) wait for one's chance",
              exampleSentences: ["那两个小偷正在伺机下手", "伺机反扑"],
              difficulty: S2Difficulty),
        Vocab(term: "心不在焉",
              definition: "\(idiom) absent-minded, preocupied",
              exampleSentences: ["他每天上课都心不在焉,老是东张西望的", "学习要专心致志，不能心不在焉"],
              difficulty: S2Difficulty),
        Vocab(term: "破天荒",
              definition: "\(idiom) occur for the first time, unprecedented",
              exampleSentence: "校长由女性担任，在本校校史上是破天荒",
              difficulty: S2Difficulty),
        Vocab(term: "仓促",
              definition: "\(adj) hurried, hasty",
              exampleSentences: ["这些往往是仓促决定的", "他们走得很仓促"],
              difficulty: S2Difficulty),
        Vocab(term: "严肃",
              definition: "\(verb) strictly enforce",
              exampleSentence: "妈妈皱着眉头，表情严肃",
              difficulty: S2Difficulty),
        Vocab(term: "安抚",
              definition: "\(verb) comfort",
              exampleSentences: ["地震灾害发生后，众多灾民及时得到了政府的安抚"],
              difficulty: S2Difficulty),
        Vocab(term: "风筝",
              definition: "\(noun) kite",
              exampleSentence: "我跟朋友去飞风筝",
              difficulty: S2Difficulty),
        Vocab(term: "挣脱",
              definition: "\(verb) to throw off, struggle free of",
              exampleSentence: "野兔挣脱了陷阱，逃向了草丛深处",
              difficulty: S2Difficulty),
        Vocab(term: "惊讶",
              definition: "\(adj) surprising, astonishing",
              exampleSentence: "他的无知令人惊讶",
              difficulty: S2Difficulty),
        Vocab(term: "斑",
              definition: "\(noun) spot, speck, spotted, striped",
              exampleSentences: ["我的衣服都血迹斑斑", "他的脸满都血泪斑斑"],
              difficulty: S2Difficulty),
        Vocab(term: "缠绕",
              definition: "\(verb) twine, bind, wind",
              exampleSentence: "到树上缠绕了绳子",
              difficulty: S2Difficulty),
        Vocab(term: "楼",
              definition: "\(verb) hold in one's arms, hug",
              exampleSentence: "她把孩子搂着",
              difficulty: S2Difficulty)
    ]),
    StudySet(title: "Chapter 2", terms: [
        Vocab(term: "捐款",
              definition: "\(noun) contribution, donation, \(verb) contribute, donate",
              exampleSentence: "一笔慷慨的捐款",
              difficulty: S2Difficulty),
        Vocab(term: "拯救",
              definition: "\(verb) save, rescue, deliver",
              exampleSentences: ["拯救野生动物", "拯救朋友"],
              difficulty: S2Difficulty),
        Vocab(term: "医疗",
              definition: "\(verb) medical or surgical treatment",
              exampleSentences: ["在这里，医疗是免费的", "医疗卫生工作"],
              difficulty: S2Difficulty),
        Vocab(term: "研究",
              definition: "\(verb) study, research",
              exampleSentence: "科学研究",
              difficulty: S2Difficulty),
        Vocab(term: "优惠",
              definition: "\(adj) preferential, favourable",
              exampleSentences: ["优惠的时间", "在对等的条件下给予优惠待遇"],
              difficulty: S2Difficulty),
        Vocab(term: "券",
              definition: "\(noun) certificate, ticket",
              exampleSentence: "我买了两片入场券",
              difficulty: S2Difficulty),
        Vocab(term: "四肢",
              definition: "\(noun) four limbs",
              exampleSentences: ["虽然我四肢无力，但我心灵手巧"],
              difficulty: S2Difficulty-1),
        Vocab(term: "敏捷",
              definition: "\(adj) quick, nimble, agile",
              exampleSentences: ["干这个工作需要思想敏捷", "他动作非常敏捷"],
              difficulty: S2Difficulty),
        Vocab(term: "穿梭",
              definition: "\(verb) shuttle back and forth",
              exampleSentence: "忙碌的蜜蜂在花丛中穿梭",
              difficulty: S2Difficulty),
        Vocab(term: "辨识",
              definition: "\(verb) identify, distinguish",
              exampleSentence: "辨识足迹",
              difficulty: S2Difficulty),
        Vocab(term: "馋",
              definition: "\(adj) greedy, gluttonous",
              exampleSentence: "这孩子不是肚子饿，就是馋",
              difficulty: S2Difficulty),
        Vocab(term: "摔跤",
              definition: "\(verb) stumble and fall",
              exampleSentence: "卓玛是女子摔跤的好手",
              difficulty: S2Difficulty),
        Vocab(term: "尤其",
              definition: "\(advb) especially, particularly",
              exampleSentences: ["小刚喜欢玩球，尤其喜欢踢足球", "他认为宠物很可爱，尤其是猫"],
              difficulty: S2Difficulty),
        Vocab(term: "光泽",
              definition: "\(noun) gloss, smoothness",
              exampleSentences: ["猫的毛色白色，没有光泽，又瘦又小", "这些珍珠的光泽都很好"],
              difficulty: S2Difficulty),
        Vocab(term: "妻子",
              definition: "\(noun) wife",
              exampleSentence: "我嫁给小美后，她就是我的妻子了",
              difficulty: S2Difficulty),
        Vocab(term: "啾啾",
              definition: "\(sound) birds chirping",
              exampleSentence: "鸟儿叽叽啾啾的叫",
              difficulty: S2Difficulty),
        Vocab(term: "仰",
              definition: "\(verb) raise, lift",
              exampleSentence: "他站在台上时，我仰着头看着他",
              difficulty: S2Difficulty),
        Vocab(term: "凝望",
              definition: "\(verb) gaze at, stare at",
              exampleSentences: ["猫凝望着天空里的鸟"],
              difficulty: S2Difficulty),
        Vocab(term: "愤怒",
              definition: "\(adj) very angry",
              exampleSentences: ["他的不诚实的行为让我感到非常愤怒"],
              difficulty: S2Difficulty),
        Vocab(term: "畏罪潜逃",
              definition: "run away to avoid punishment",
              exampleSentences: ["小偷看到警察即将来领，便立刻畏罪潜逃"],
              difficulty: S2Difficulty),
        Vocab(term: "衔着",
              definition: "\(verb) hold in the mouth",
              exampleSentence: "猫衔着鸟的头",
              difficulty: S2Difficulty),
        Vocab(term: "搞",
              definition: "\(verb) do, did",
              exampleSentence: "是我搞错的",
              difficulty: S2Difficulty),
        Vocab(term: "失踪",
              definition: "\(verb) be missing, dissapear",
              exampleSentence: "他已经失踪了，我找不到他",
              difficulty: S2Difficulty),
        Vocab(term: "估计",
              definition: "\(verb) estimate, reckon",
              exampleSentences: ["我估计他已经死了"],
              difficulty: S2Difficulty),
        Vocab(term: "盘旋",
              definition: "\(verb) circle, eg. vultures circling",
              exampleSentences: ["鸟在空中盘旋"],
              difficulty: S2Difficulty),
        Vocab(term: "丝毫",
              definition: "\(adj) slightly, in the slightest manner",
              exampleSentences: ["丝毫不爽", "没有丝毫的遗憾"],
              difficulty: S2Difficulty),
        Vocab(term: "面面相觑",
              definition: "\(idiom) look at each other in blank dismay",
              exampleSentence: "我与朋友面面相觑，不知道要真么做",
              difficulty: S2Difficulty),
        Vocab(term: "愣",
              definition: "\(verb) dumbfounded",
              exampleSentences: ["愣了半天", "你还愣着做什么，快把东西还给他！"],
              difficulty: S2Difficulty),
    ]),
    StudySet(title: "Chapter 3", terms: [
        Vocab(term: "水喉",
              definition: "\(noun) tap (not commonly used)",
              exampleSentences: ["打开水喉"],
              difficulty: S2Difficulty),
        Vocab(term: "艰巨",
              definition: "\(adj) formidable, enormous",
              exampleSentence: "艰巨的挑战",
              difficulty: S2Difficulty),
        Vocab(term: "昂贵",
              definition: "\(noun) expensive, costly",
              exampleSentences: ["那台手机很昂贵", "制造成本很昂贵"],
              difficulty: S2Difficulty),
        Vocab(term: "干旱",
              definition: "\(adj) (of weather or soil) arid, dry",
              exampleSentence: "天气干旱",
              difficulty: S2Difficulty),
        Vocab(term: "扩大",
              definition: "\(verb) expand, enlarge",
              exampleSentences: ["扩大生产", "扩大词汇量"],
              difficulty: S2Difficulty),
        Vocab(term: "蓄水池",
              definition: "\(noun) reservoir",
              exampleSentences: ["你不能往蓄水池内乱丢垃圾"],
              difficulty: S2Difficulty),
        Vocab(term: "趋势",
              definition: "\(noun) trend, tendency",
              exampleSentence: "有下降的趋势",
              difficulty: S2Difficulty),
        Vocab(term: "媒体",
              definition: "\(noun) mass media, social media",
              exampleSentences: ["政府对社交媒体有着严厉的管理政策"],
              difficulty: S2Difficulty),
        Vocab(term: "吨",
              definition: "\(noun) tons (unit of measurement)",
              exampleSentence: "一百吨",
              difficulty: S2Difficulty),
        Vocab(term: "廉价",
              definition: "\(adj) low priced, cheap",
              exampleSentences: ["这台手机价格廉价，肯定质量不好"],
              difficulty: S2Difficulty),
        Vocab(term: "污染",
              definition: "\(noun) pollution, \(verb) pollute",
              exampleSentences: ["空气污染", "附近的工厂造成了环境污染"],
              difficulty: S2Difficulty),
        Vocab(term: "焚烧",
              definition: "\(verb) burn, set on fire",
              exampleSentences: ["焚烧垃圾会让空气质量下降"],
              difficulty: S2Difficulty),
        Vocab(term: "烟尘",
              definition: "\(noun) smoke and dust",
              exampleSentences: ["烟尘污染要减轻，集中供热是途径"],
              difficulty: S2Difficulty),
        Vocab(term: "土壤",
              definition: "\(noun) soil",
              exampleSentences: ["植物从土壤里吸收养分"],
              difficulty: S2Difficulty),
        Vocab(term: "遏制",
              definition: "\(verb) keep within limits, contain",
              exampleSentence: "遏制不住自己的笑声",
              difficulty: S2Difficulty),
        Vocab(term: "倡导",
              definition: "\(verb) initiate, advocate",
              exampleSentences: ["我们要理直气壮地倡导科学，反对迷信导"],
              difficulty: S2Difficulty),
        Vocab(term: "逐渐",
              definition: "\(advb) gradually",
              exampleSentences: ["天逐渐暗了下来", "树叶逐渐枯黄了"],
              difficulty: S2Difficulty),
        Vocab(term: "威胁",
              definition: "\(verb) threaten",
              exampleSentence: "这件事威胁全世界",
              difficulty: S2Difficulty),
        Vocab(term: "煞费苦心",
              definition: "\(idiom) rack one's brains, take great pains",
              exampleSentences: ["煞费苦心想办法", "煞费苦心地寻找借口"],
              difficulty: S2Difficulty),
        Vocab(term: "泛滥",
              definition: "\(verb) overflow, out of control",
              exampleSentences: ["河水泛滥", "任其泛滥"],
              difficulty: S2Difficulty),
        Vocab(term: "寿命",
              definition: "\(noun) lifespan",
              exampleSentences: ["电池的寿命", "人的平均寿命是八十岁"],
              difficulty: S2Difficulty),
        Vocab(term: "途径",
              definition: "\(noun) way, channel",
              exampleSentence: "读报纸是我们获取知识的一个重要途径",
              difficulty: S2Difficulty),
        Vocab(term: "缺乏",
              definition: "\(verb) lack, be in want of",
              exampleSentence: "小明因为缺乏经验，所以他没有通过公司的面试",
              difficulty: S2Difficulty),
        Vocab(term: "遗憾",
              definition: "\(noun) regret",
              exampleSentence: "抱有遗憾的退出比赛",
              difficulty: S2Difficulty),
        Vocab(term: "妥善",
              definition: "\(adj) appropriate, proper",
              exampleSentence: "外出旅行时要做妥善安排",
              difficulty: S2Difficulty),
    ]),
    StudySet(title: "Chapter 4", terms: [
        Vocab(term: "自卑",
              definition: "\(adj) feel inferior",
              exampleSentence: "我感觉自卑",
              difficulty: S2Difficulty),
        Vocab(term: "羡慕",
              definition: "\(verb) admire, envy",
              exampleSentence: "每次看到别人优秀的成绩，我都非常羡慕",
              difficulty: S2Difficulty),
        Vocab(term: "诱惑",
              definition: "\(verb) entice, tempt, seduce",
              exampleSentences: ["抵御诱惑", "我经不起诱惑"],
              difficulty: S2Difficulty),
        Vocab(term: "毅力",
              definition: "\(noun) willpower",
              exampleSentences: ["我要做一个有毅力的人", "完成这项工作需要坚强的毅力"],
              difficulty: S2Difficulty),
        Vocab(term: "茫然",
              definition: "\(adj) ignorant, at a loss",
              exampleSentences: ["我注意到他一脸茫然，连忙问他是否有疑问", "茫然不解"],
              difficulty: S2Difficulty),
        Vocab(term: "瞌睡",
              definition: "\(verb) feel sleepy, feel drowsy",
              exampleSentences: ["他竟然在华文课上打瞌睡", "我昨天没睡好，白天不停地打瞌睡"],
              difficulty: S2Difficulty),
        Vocab(term: "嫌",
              definition: "\(noun) suspicion, \(verb) suspicious",
              exampleSentence: "哥哥嫌我电脑用的太久",
              difficulty: S2Difficulty),
        Vocab(term: "逼",
              definition: "\(verb) force, compel, press",
              exampleSentence: "哥哥逼我把电脑让出来",
              difficulty: S2Difficulty),
        Vocab(term: "烹饪",
              definition: "\(verb) cooking, \(noun) cooking, culinary art",
              exampleSentence: "我对烹饪的兴趣越来越大",
              difficulty: S2Difficulty),
        Vocab(term: "符合",
              definition: "\(verb) accord with, tally with, conform to",
              exampleSentences: ["我梦想不符合爸爸的期望", "我们必须符合他们的要求"],
              difficulty: S2Difficulty),
        Vocab(term: "憋",
              definition: "\(verb) suppress, hold back",
              exampleSentences: ["这句话憋在我心里好久了", "我憋住气潜入深海中"],
              difficulty: S2Difficulty),
        Vocab(term: "委婉",
              definition: "\(adj) mild and roundabout, indirect",
              exampleSentences: ["我们委婉的提醒了他多次", "他批评时很委婉"],
              difficulty: S2Difficulty),
        Vocab(term: "锋",
              definition: "\(noun) seam, crack, crevice, fissure",
              exampleSentence: "那位铁匠经验丰富，造出来的每一把剑都锋利无比",
              difficulty: S2Difficulty),
        Vocab(term: "掩",
              definition: "\(verb) cover, hide",
              exampleSentence: "掩在门后面",
              difficulty: S2Difficulty),
        Vocab(term: "恐惧",
              definition: "\(adj) fearful, scared",
              exampleSentences: ["在我们的眼睛里都看到了恐惧", "恐惧不安"],
              difficulty: S2Difficulty),
        Vocab(term: "锁",
              definition: "\(noun) lock, \(verb) lock (up)",
              exampleSentences: ["我锁上门", "我忘了带锁匙，只能请锁匠来撬锁"],
              difficulty: S2Difficulty),
        Vocab(term: "熄灯",
              definition: "\(verb) turn off the lights",
              exampleSentence: "在宿舍，熄灯后不许大声说话",
              difficulty: S2Difficulty),
        Vocab(term: "颤抖",
              definition: "\(verb) shake, tremble, shiver",
              exampleSentences: ["我的声音有些颤抖", "我冷得全身颤抖"],
              difficulty: S2Difficulty),
        Vocab(term: "瑟瑟",
              definition: "\(sound) rustling, \(adj) shivering",
              exampleSentence: "瑟瑟发抖",
              difficulty: S2Difficulty),
        Vocab(term: "恐怖",
              definition: "\(noun) terror, horror",
              exampleSentence: "我没想到恐怖事件真的会在我国发生",
              difficulty: S2Difficulty),
        Vocab(term: "通宵",
              definition: "\(noun) all night, the whole night",
              exampleSentence: "他明天有很多功课要叫上，只好通宵",
              difficulty: S2Difficulty),
        Vocab(term: "惊悚",
              definition: "\(adj) frightening, horrifying",
              exampleSentences: ["很多事情不管是真是假，如果只是听说，无论多么惊悚，都不过是一个故事而已。"],
              difficulty: S2Difficulty),
        Vocab(term: "缺陷",
              definition: "\(noun) defect, drawback, flaw",
              exampleSentences: ["我们必须注意自己的缺陷", "我们不该取笑别人的缺陷"],
              difficulty: S2Difficulty),
        Vocab(term: "姿势",
              definition: "\(noun) posture",
              exampleSentence: "如果我们看书的姿势不正确，日久天长就会影响视力。",
              difficulty: S2Difficulty),
        Vocab(term: "拘束",
              definition: "\(verb) restrain, restrict, \(adj) restraining",
              exampleSentence: "我们不要拘束孩子们的创造力",
              difficulty: S2Difficulty),
        Vocab(term: "嘈杂",
              definition: "\(adj) noisy",
              exampleSentence: "老师一离开，教室就变得很嘈杂",
              difficulty: S2Difficulty),
        Vocab(term: "沮丧",
              definition: "\(verb) depress, dishearten, \(adj) depressed",
              exampleSentence: "我在考试中不及格，感到很沮丧",
              difficulty: S2Difficulty),
        Vocab(term: "若有所思",
              definition: "\(idiom) look distracted, as if thinking",
              exampleSentence: "他在课上一直望着窗外，若有所失的样子，根本没专心听课",
              difficulty: S2Difficulty)
    ]),
    StudySet(title: "Chapter 5", terms: [
        Vocab(term: "简陋",
              definition: "\(adj) simple and crude, shabby",
              exampleSentence: "这么简陋的山村学校，居然培养出那么多的优秀学生",
              difficulty: S2Difficulty),
        Vocab(term: "开辟",
              definition: "\(verb) to open up, to establish",
              exampleSentences: ["开辟新天地", "最近，首都机场又开辟了一条国际航线。"],
              difficulty: S2Difficulty),
        Vocab(term: "宗教",
              definition: "\(noun) religion",
              exampleSentences: ["宗教活动", "宗教信仰"],
              difficulty: S2Difficulty),
        Vocab(term: "综合",
              definition: "\(noun) multiple, poly (eg. polyclinic, 综合诊所)",
              exampleSentence: "我的家里下面有个综合诊疗",
              difficulty: S2Difficulty),
        Vocab(term: "经济",
              definition: "economy, economic",
              exampleSentence: "新加坡经济",
              difficulty: S2Difficulty),
        Vocab(term: "蓬勃",
              definition: "\(adj) vigorous, flourishing",
              exampleSentences: ["新生事物蓬勃兴起", "少气蓬勃的青年"],
              difficulty: S2Difficulty),
        Vocab(term: "富裕",
              definition: "\(adj) well to do",
              exampleSentences: ["新加坡越来越富裕", "日子得挺富裕"],
              difficulty: S2Difficulty),
        Vocab(term: "变迁",
              definition: "\(verb) undergo change",
              exampleSentences: ["社会变迁", "随时代而变迁"],
              difficulty: S2Difficulty),
        Vocab(term: "障碍",
              definition: "\(noun) obstacle",
              exampleSentences: ["扫清障碍", "支招障碍"],
              difficulty: S2Difficulty),
        Vocab(term: "驰名",
              definition: "\(adj) known far and wide, popular",
              exampleSentences: ["新加坡的驰名飞机场", "我的爸爸是一个驰名的人"],
              difficulty: S2Difficulty),
        Vocab(term: "屡次",
              definition: "\(advb) time and again, repeatedly",
              exampleSentences: ["屡次没听我的话", "我屡次高数他不要那里玩"],
              difficulty: S2Difficulty),
        Vocab(term: "荣誉",
              definition: "\(noun) honour, glory",
              exampleSentences: ["个人荣誉", "获得许多荣誉"],
              difficulty: S2Difficulty),
        Vocab(term: "姿态",
              definition: "\(noun) posture",
              exampleSentences: ["各种不同姿态的泥塑", "他的姿态看的好像香蕉"],
              difficulty: S2Difficulty),
        Vocab(term: "翠绿",
              definition: "\(adj) dark green, emerald green",
              exampleSentences: ["树上满都是翠绿的叶子", ""],
              difficulty: S2Difficulty),
        Vocab(term: "心旷神域",
              definition: "\(idiom) relaxed and joyful",
              exampleSentence: "去外面走一走，会令你心旷神怡",
              difficulty: S2Difficulty),
        Vocab(term: "合拢",
              definition: "close up, join together",
              exampleSentences: ["龙口合龙", "叶子合龙起来，好像一把大雨伞"],
              difficulty: S2Difficulty),
        Vocab(term: "林荫",
              definition: "\(noun) shade of trees",
              exampleSentence: "我坐在林荫下休息",
              difficulty: S2Difficulty),
        Vocab(term: "樟宜",
              definition: "\(noun) Changi, eg. Changi Airport",
              exampleSentence: "我在樟宜机场等飞机",
              difficulty: S2Difficulty),
        Vocab(term: "耸立",
              definition: "\(verb) tower aloft, tower above",
              exampleSentence: "雨树耸立在土地上",
              difficulty: S2Difficulty),
        Vocab(term: "温馨",
              definition: "\(adj) soft and sweet, warm",
              exampleSentences: ["温馨的唇液", "温馨的情谊"],
              difficulty: S2Difficulty),
        Vocab(term: "粗糙",
              definition: "\(adj) coarse, rough",
              exampleSentences: ["他的皮肤好粗糙", "那颗树有很粗糙的枝干"],
              difficulty: S2Difficulty),
        Vocab(term: "婆娑",
              definition: "\(adj) whirling, dancing",
              exampleSentences: ["婆娑起舞", "杨柳婆娑"],
              difficulty: S2Difficulty),
        Vocab(term: "茁壮",
              definition: "\(adj) strong and healthy",
              exampleSentences: ["小麦长得很茁壮", "茁壮成长"],
              difficulty: S2Difficulty),
        Vocab(term: "接纳",
              definition: "\(verb) admit (into an organisation)",
              exampleSentence: "接纳新会员",
              difficulty: S2Difficulty),
        Vocab(term: "患",
              definition: "\(noun) trouble, \(verb) worry",
              exampleSentences: ["后患", "不患人之不己知"],
              difficulty: S2Difficulty),
        Vocab(term: "失智症",
              definition: "\(noun) dementia",
              exampleSentence: "我的爷爷有失智症，每天会忘许多事件",
              difficulty: S2Difficulty),
        Vocab(term: "流逝",
              definition: "\(verb) (of time) pass, elapse",
              exampleSentences: ["随着时间的流逝"],
              difficulty: S2Difficulty),
        Vocab(term: "嬉戏",
              definition: "\(verb) play, sport",
              exampleSentence: "孩子们在草坪上嬉戏",
              difficulty: S2Difficulty),
        Vocab(term: "咖喱卜",
              definition: "\(noun) curry puff",
              exampleSentences: ["我每天回家会吃一个咖喱卜", "咖喱卜不够辣"],
              difficulty: S2Difficulty),
        Vocab(term: "俏皮",
              definition: "\(adj) good looking, smart looking, smart",
              exampleSentences: ["他显得很俏皮"],
              difficulty: S2Difficulty),
    ]),
    StudySet(title: "Chapter 6", terms: [
        Vocab(term: "贸易",
              definition: "\(noun) trade, commerce",
              exampleSentence: "我国经常和其他国进行贸易",
              difficulty: S2Difficulty),
        Vocab(term: "丝绸",
              definition: "\(noun) silk (cloth)",
              exampleSentence: "古代时，很多大官会穿用丝绸做来的衣服",
              difficulty: S2Difficulty),
        Vocab(term: "陆地",
              definition: "\(noun) (dry) land",
              exampleSentence: "大海再宽广也要连着陆地",
              difficulty: S2Difficulty),
        Vocab(term: "奢侈",
              definition: "\(adj) luxurious, extravagant, wasteful",
              exampleSentence: "国王每天生化奢侈，把全国的钱都用光了",
              difficulty: S2Difficulty),
        Vocab(term: "瓷器",
              definition: "\(noun) porcelain, chinaware",
              exampleSentence: "这项瓷器一路上磕磕碰碰的，碎了不少片",
              difficulty: S2Difficulty),
        Vocab(term: "仪式",
              definition: "\(noun) ceremony, ritual, function, rite",
              exampleSentence: "随着仪式结束，客人全部告退了",
              difficulty: S2Difficulty),
        Vocab(term: "秉持",
              definition: "\(verb) adhere to (principles), to uphold",
              exampleSentence: "小明秉持诚信，树立好榜样",
              difficulty: S2Difficulty),
        Vocab(term: "枢纽",
              definition: "\(noun) hub, axis, key position",
              exampleSentence: "这里是南北交通的枢纽",
              difficulty: S2Difficulty),
        Vocab(term: "港口",
              definition: "\(noun) (coastal) port, harbour",
              exampleSentence: "新的港口已向外轮开放",
              difficulty: S2Difficulty),
        Vocab(term: "致力",
              definition: "\(verb) devote or dedicate (yourself) to / work for",
              exampleSentence: "他一生致力于科学事业，发明了很多东西",
              difficulty: S2Difficulty),
        Vocab(term: "勾勒",
              definition: "\(verb) draw the outline of something",
              exampleSentence: "我将用自己的努力勾勒出了那幅画",
              difficulty: S2Difficulty),
        Vocab(term: "高瞻远瞩",
              definition: "\(idiom) have the foresight",
              exampleSentence: "每当家里有什么大事，爸爸总是能高瞻远瞩，解决事情",
              difficulty: S2Difficulty),
        Vocab(term: "可谓",
              definition: "\(verb) one may as well say",
              exampleSentence: "为了我们健康成长，老师可谓煞费苦心",
              difficulty: S2Difficulty),
        Vocab(term: "岛屿",
              definition: "\(noun) islands",
              exampleSentence: "水天相接，岛屿隐现",
              difficulty: S2Difficulty),
        Vocab(term: "海峡",
              definition: "\(noun) strait, channel",
              exampleSentence: "他是首位横渡英吉利海峡的残疾人",
              difficulty: S2Difficulty),
        Vocab(term: "历史",
              definition: "\(noun) history",
              exampleSentence: "我们不能不提到某些历史事实",
              difficulty: S2Difficulty),
        Vocab(term: "挖掘",
              definition: "\(verb) excavate, unearth",
              exampleSentence: "挖掘地下保藏",
              difficulty: S2Difficulty),
        Vocab(term: "区域",
              definition: "\(noun) area, district, region",
              exampleSentence: "我们只能在划定的区域内游泳",
              difficulty: S2Difficulty),
        Vocab(term: "汇集",
              definition: "\(verb) collect and compile, assemble, converge",
              exampleSentence: "运动会即将开始了，各班的运动员都汇集到了操场上",
              difficulty: S2Difficulty),
        Vocab(term: "赋予",
              definition: "\(verb) entrust, assign",
              exampleSentence: "国王赋予军人一项使命",
              difficulty: S2Difficulty),
        Vocab(term: "海纳百川",
              definition: "\(idiom) use different means to obtain the same result",
              exampleSentence: "海纳百川，有容乃大",
              difficulty: S2Difficulty),
        Vocab(term: "椰浆饭",
              definition: "\(noun) nasi lemak (coconut rice)",
              exampleSentence: "小明很喜欢吃椰浆饭",
              difficulty: S2Difficulty),
        Vocab(term: "黄浆饭",
              definition: "\(noun) Nasi Kunyit (Tumeric Rice)",
              exampleSentence: "小明很喜欢吃黄浆饭",
              difficulty: S2Difficulty),
        Vocab(term: "发芽",
              definition: "\(verb) germinate, sprout",
              exampleSentence: "昨天种的种子当然还没发芽啊",
              difficulty: S2Difficulty),
        Vocab(term: "兼容并蓄",
              definition: "\(idiom) incorporate things of diverse nature",
              exampleSentence: " 如果想要干一番大事业，就要多方兼容并蓄",
              difficulty: S2Difficulty),
        Vocab(term: "携手",
              definition: "\(verb) join hands",
              exampleSentence: "让我们一起携起手来，共同前进吧",
              difficulty: S2Difficulty),
        Vocab(term: "辉煌",
              definition: "\(adj) brilliant, splendid, glorious",
              exampleSentence: "在王将军的带领下，我国得到了辉煌的战果",
              difficulty: S2Difficulty),
        Vocab(term: "皇帝",
              definition: "\(noun) emperor",
              exampleSentence: "皇帝刚刚去世",
              difficulty: S2Difficulty),
        Vocab(term: "典型",
              definition: "\(noun) a typical instance (case)",
              exampleSentence: "问题虽小，但很典型",
              difficulty: S2Difficulty),
        Vocab(term: "普及",
              definition: "\(verb) make universal, popularized",
              exampleSentence: "这本书已经普及全国",
              difficulty: S2Difficulty),
        Vocab(term: "真伪",
              definition: "\(noun) true and false",
              exampleSentence: "他还小，不能别其真伪",
              difficulty: S2Difficulty),
        Vocab(term: "步伐",
              definition: "\(noun) step, pace",
              exampleSentence: "紧跟时间的步伐",
              difficulty: S2Difficulty),
        Vocab(term: "询问",
              definition: "\(verb) inquire",
              exampleSentence: "我询问他的学习情况",
              difficulty: S2Difficulty),
        Vocab(term: "人云亦云",
              definition: "\(idiom) echo the views of others, have no views of one's own",
              exampleSentence: "不要人云亦云地确定自己的目标，只有你自己知道，对你来说什么是最好的",
              difficulty: S2Difficulty),
        Vocab(term: "免疫",
              definition: "\(verb) be immune, immunity",
              exampleSentence: "感染一次病毒会增强免疫力",
              difficulty: S2Difficulty),
        Vocab(term: "凝聚力",
              definition: "\(noun) cohesion",
              exampleSentence: "这个公司的员工缺乏沟通，凝聚力相当薄弱",
              difficulty: S2Difficulty),
    ]),
], editable: false)
