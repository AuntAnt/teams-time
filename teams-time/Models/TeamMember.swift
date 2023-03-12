//
//  TeamMember.swift
//  teams-time
//
//  Created by Anton Kuzmin on 09.03.2023.
//

struct TeamMember {
    var name: String
    var jobTitle: String
    var timezone: Timezone
    var workingTime: WorkingTime
    var contact: String?
    
    init(name: String,
         jobTitle: String = "iOS Developer",
         timezone: Timezone,
         workingTime: WorkingTime = WorkingTime(from: 9, to: 18),
         contact: String?
    ) {
        self.name = name
        self.jobTitle = jobTitle
        self.timezone = timezone
        self.workingTime = workingTime
        self.contact = contact
    }
    
    static func getMembers() -> [TeamMember] {
        [
          TeamMember(name: "Anton", jobTitle: "Project Manager", timezone: .samara, contact: "@auntant"),
          TeamMember(name: "Bektemur", timezone: .tashkent, contact: "bektemur07"),
          TeamMember(name: "Aigiz", timezone: .dublin, contact: "@iGiz_13"),
          TeamMember(name: "Ilya", timezone: .minsk, contact: "@ilyastratovich"),
          TeamMember(name: "Anna", timezone: .samara, contact: "@belikovanna")
        ]
    }
}

struct WorkingTime {
    var from: Int
    var to: Int
}

enum Timezone: String {
    case kiev = "Europe/Kiev"
    case minsk = "Europe/Minsk"
    case moscow = "Europe/Moscow"
    case samara = "Europe/Samara"
    case dublin = "Europe/Dublin"
    case london = "Europe/London"
    case tashkent = "Asia/Tashkent"
    case bishkek = "Asia/Bishkek"
    case almaty = "Asia/Almaty"
}

enum Status: String {
    case active = "Active"
    case inactive = "Inactive"
}
