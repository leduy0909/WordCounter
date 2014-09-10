//
//  WordCounter.swift
//  DemoClass
//
//  Created by techmaster on 9/9/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
class Word {
    var word: String
    var count: Int = 1
    init(word: String) {
        self.word = word
    }
    func increment() {
        self.count += 1
    }
}
class WordCounter: GenericVC {

    var WordCountNSort: [Word] = [Word]()
    var WordCountNSort2: [Word] = [Word]()
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  if let plainString = self.readFileToString("data.txt") {
            self.countWord(plainString)
        }*/
        
        self.countWord("I like this. i hate that dog. Cat is fun,joke,love: is it cool?. dog,flower;dog. hate is bad hate.Love is all around. Red blue green yellow violet sexy yeah yeah dad dad dad dad around around around around around ")

    }
    // doc file -> string
    func readFileToString(textFile: String) -> String? {
        let fileNameArr = textFile.componentsSeparatedByString(".")
        if fileNameArr.count != 2 { return nil }
        
        let filePath = NSBundle.mainBundle().pathForResource(fileNameArr[0], ofType: fileNameArr[1])
        println("\(filePath)")
        
        return String.stringWithContentsOfFile(filePath!, encoding: NSUTF8StringEncoding, error: nil)
    }
    // loai bo cac tu k can thiet
    func shouldRemoveThisWord(word: String) -> Bool {
    
        let dummyWords = ["", " ","a", "all", "an", "i", "in", "is", "it", "are", "were", "he", "she", "they", "it's", "my", "his", "her", "their", "this", "that", "very", "much"]
        if contains(dummyWords, word) { return true }
        
        return false;
    }
    
    func countWord(inputString: String) {
        let separator = NSMutableCharacterSet(charactersInString: " .,:;?!")
        let rawWordArray = inputString.lowercaseString.componentsSeparatedByCharactersInSet(separator)
       
        /* ok nhung khong sort duoc
        let wordSet = NSCountedSet()
        for word in rawWordArray {
            if !self.shouldRemoveThisWord(word) {
                wordSet.addObject(word)
            }
        }
        
        for word in wordSet {
            self.inRa("\(word) : \(wordSet.countForObject(word))")
        }*/
        
        for word in rawWordArray {
            if !self.shouldRemoveThisWord(word) {
                self.insertWordToWordCountNSort(word)
            }
        }
        for i in 0..<(WordCountNSort.count - 1) {
            for j in (i + 1)...(WordCountNSort.count - 1) {
                var count = WordCountNSort[j].count
                var word = WordCountNSort[j].word
                if WordCountNSort[i].count < WordCountNSort[j].count {
                    WordCountNSort[j].word = WordCountNSort[i].word
                    WordCountNSort[i].word = word
                    WordCountNSort[j].count = WordCountNSort[i].count
                    WordCountNSort[i].count = count
                }
            }
        }
            for item in WordCountNSort {
                self.inRa("\(item.word) : \(item.count)")
        }
}
    func insertWordToWordCountNSort(word: String) {
        var index = 0
        if (WordCountNSort.count == 0) {
            WordCountNSort.append(Word(word: word))
            return
        }
        
        for item in WordCountNSort {
            if (word > item.word) {
                WordCountNSort.insert(Word(word: word), atIndex: index)
                return
            } else if (word == item.word) {
                item.increment()
                return
            } else if (word < item.word) {
                index++
                if (index == WordCountNSort.count) {
                    WordCountNSort.append(Word(word: word))
                }
            }
        }
        
    }
}
