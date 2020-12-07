//
//  CounterConstants.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

struct CounterConstants {
    
    struct Url {
        struct Path {
            static let counters = "counters"
            static let counter = "counter"
            static let inc = "inc"
            static let dec = "dec"
        }
    }
    struct Welcome {
        static let continueText = "continue"
        static let titleWord = "title_word"
        static let title = "title"
    }
    
    struct Counters {
        static let edit = "edit"
        static let title = "title"
        static let noCounters = "no_counters"
        static let noCountersDescription = "no_counters_description"
        static let createCounters = "create_counters"
        static let done = "done"
        static let selectAll = "select_all"
        static let titleFiledLoad = "title_filed_load"
        static let descriptionFailedLoad = "description_failed_load"
        static let retry = "retry"
    }
    
    struct CounterCreate {
        static let title = "title"
        static let examples = "examples"
        static let cancel = "cancel"
        static let save = "save"
        static let counterPlaceholder = "counter_placeholder"
        static let underlineExamples = "underline_examples"
    }
    
    struct CreateCounterExample {
        static let title = "title"
        static let create = "create"
    }
    
    struct View {
        struct CounterCell {
            static let leadingDefault: CGFloat = 16
            static let leadingExpand: CGFloat = 55
        }
        
        struct ResultView {
            static let defaultWidthBtn: CGFloat = 150
            static let retryWidthBtn: CGFloat = 75
        }
        
        struct CreateCounterExample {
            static let borderHeight: CGFloat = 0.2
        }
    }
    
    struct Font {
        static let regular = "SF Pro Display Regular"
    }
}
