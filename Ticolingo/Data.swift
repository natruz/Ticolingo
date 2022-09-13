//
//  Data.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import Foundation

class StudySetGroup: ObservableObject, Codable, Identifiable {
    var name: String
    var sets: [StudySet]
    
    init(name: String, sets: [StudySet]) {
        self.name = name
        self.sets = sets
    }
}

class StudySet: ObservableObject, Codable, Identifiable {
    
    var id = UUID()
    
    var title: String
    var terms: [Vocab]
    
    init(title: String, terms: [Vocab]) {
        self.title = title
        self.terms = terms
    }
}

class Vocab: ObservableObject, Codable, Identifiable {
    
    var id = UUID()
    
    var term: String
    var definition: String
    var exampleSentence: String
    var difficulty: Int
    var familiarity = false
    
    init(term: String,
         definition: String,
         exampleSentence: String,
         difficulty: Int) {
        self.term = term
        self.definition = definition
        self.exampleSentence = exampleSentence
        self.difficulty = difficulty
    }
}

var studyGroups = [
    StudySetGroup(name: "Feelings", sets: [
        StudySet(title: "Happy Terms", terms: [
            Vocab(term: "高兴", definition: "happy", exampleSentence: "我很高兴认识你。", difficulty: 0),
            Vocab(term: "快乐", definition: "happiness", exampleSentence: "小学的时候我很快乐。", difficulty: 3),
            Vocab(term: "开心", definition: "happy", exampleSentence: "我很开心能够帮助你。", difficulty: 0),
            Vocab(term: "幸福", definition: "happy", exampleSentence: "我们希望你幸福。", difficulty: 0),
            Vocab(term: "欢乐", definition: "happy", exampleSentence: "欢乐是生活的一部分。", difficulty: 0),
            Vocab(term: "笑", definition: "smile", exampleSentence: "我笑着看着你。", difficulty: 0),
            Vocab(term: "微笑", definition: "smile", exampleSentence: "微笑是一种语言。", difficulty: 0),
            Vocab(term: "喜欢", definition: "like", exampleSentence: "我喜欢你。", difficulty: 0),
            Vocab(term: "喜爱", definition: "love", exampleSentence: "我喜爱你。", difficulty: 0),
            Vocab(term: "亲爱的", definition: "dear", exampleSentence: "亲爱的，我错了。", difficulty: 0),
            Vocab(term: "幸运", definition: "lucky", exampleSentence: "你是幸运的。", difficulty: 0),
            Vocab(term: "愉快", definition: "pleased", exampleSentence: "愉快的时光总是短暂的。", difficulty: 0),
            Vocab(term: "兴奋", definition: "excited", exampleSentence: "我很兴奋。", difficulty: 0),
            Vocab(term: "满意", definition: "satisfied", exampleSentence: "我很满意。", difficulty: 0),
            Vocab(term: "热爱", definition: "love", exampleSentence: "我热爱你。", difficulty: 0),
            Vocab(term: "自由", definition: "free", exampleSentence: "自由是一种幸福。", difficulty: 0),
            Vocab(term: "平安", definition: "safe", exampleSentence: "平安是一种幸福。", difficulty: 0),
            Vocab(term: "健康", definition: "healthy", exampleSentence: "健康是一种幸福。", difficulty: 0),
        ]),
        StudySet(title: "Sad Terms", terms: [
            Vocab(term: "悲伤", definition: "sorrow", exampleSentence: "我不能找到我的电脑，我很悲伤。", difficulty: 0),
            Vocab(term: "忧伤", definition: "sad", exampleSentence: "我很忧伤。", difficulty: 0),
            Vocab(term: "沮丧", definition: "discouraged", exampleSentence: "沮丧的心情会影响你的工作。", difficulty: 0),
            Vocab(term: "悲痛", definition: "grief", exampleSentence: "他的悲痛难以言表。", difficulty: 0),
            Vocab(term: "悲哀", definition: "sorrow", exampleSentence: "他的悲哀难以言表。", difficulty: 0),
            Vocab(term: "忧愁", definition: "sorrow", exampleSentence: "忧愁会影响你的身体健康。", difficulty: 0),
            Vocab(term: "憔悴", definition: "gaunt", exampleSentence: "他的脸色苍白，看起来憔悴不堪。", difficulty: 0),
            Vocab(term: "苦恼", definition: "troubled", exampleSentence: "他的心情很不好，一直苦恼不已。", difficulty: 0),
            Vocab(term: "恼火", definition: "annoyed", exampleSentence: "他的恼火会影响他的工作。", difficulty: 0),
            Vocab(term: "懊恼", definition: "regretful", exampleSentence: "他懊恼自己做了那件事。", difficulty: 0),
            Vocab(term: "伤心", definition: "sad", exampleSentence: "他伤心欲绝。", difficulty: 0),
            Vocab(term: "难过", definition: "sad", exampleSentence: "他难过欲绝。", difficulty: 0),
            Vocab(term: "沮丧", definition: "sad", exampleSentence: "他沮丧欲绝。", difficulty: 0),
            Vocab(term: "忧愁", definition: "sad", exampleSentence: "他忧愁欲绝。", difficulty: 0),
            Vocab(term: "悲伤", definition: "sad", exampleSentence: "他悲伤欲绝。", difficulty: 0),
            Vocab(term: "悲痛", definition: "sad", exampleSentence: "他悲痛欲绝。", difficulty: 0),
            Vocab(term: "忧虑", definition: "worried", exampleSentence: "他忧虑的神色使他看起来很紧张。", difficulty: 0),
            Vocab(term: "焦虑", definition: "anxious", exampleSentence: "他焦虑的神色使他看起来很紧张。", difficulty: 0),
            Vocab(term: "烦恼", definition: "annoyed", exampleSentence: "他烦恼的神色使他看起来很紧张。", difficulty: 0),
        ]),
    ]),
    StudySetGroup(name: "Weather", sets: [
        StudySet(title: "Sunny", terms: [
            Vocab(term: "", definition: "", exampleSentence: "", difficulty: 0)
        ]),
    ]),
    // Other sections: Speaking(how to say "shuo")
]
