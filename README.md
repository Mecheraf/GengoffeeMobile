# Mobile application for Gengoffee

An application built for the organisation and staff of Gengoffee. 
Offline version available for tests.

## Requierments 

Xcode
iPhone iOS 15 or + 

Warning : 

The application has not be designed for iPad yet. 
The UI is only adjusted for iPhone.

```bash 
Gengoffee Mobile
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   ├── Contents.json
│   │   └── Logo-Blanc-Fond-Bleu.png
│   └── Contents.json
├── ContentView.swift
├── Gengoffee_MobileApp.swift
├── Item.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── assets
│   ├── Colors.swift
│   ├── Extensions.swift
│   └── Variables.swift
├── design
│   ├── Events
│   │   └── eventDisplay.swift
│   ├── GeneralUI
│   │   ├── FooterDesign.swift
│   │   ├── MinimizeButton.swift
│   │   └── designButton.swift
│   └── Tables
│       ├── attendeePin.swift
│       ├── tableButtons.swift
│       ├── tablePin.swift
│       └── tableStyle.swift
├── models
│   ├── Attendee.swift
│   ├── EventModel.swift
│   ├── MainModel.swift
│   ├── TableModel.swift
│   └── UserModel.swift
├── services
│   ├── AttendeesService.swift
│   ├── ColorService.swift
│   ├── DateService.swift
│   ├── EventService.swift
│   ├── GeneralService.swift
│   ├── RegisteredService.swift
│   ├── TablesService.swift
│   ├── TextService.swift
│   └── UserService.swift
├── shared
│   ├── FooterComponent.swift
│   └── HeaderComponent.swift
└── views
    ├── AddRegister
    │   ├── AddBulk.swift
    │   ├── AddLocalRegister.swift
    │   └── AddRegisterView.swift
    ├── Attendees
    │   ├── AttendeesDetails.swift
    │   ├── AttendeesList.swift
    │   └── AttendeesRow.swift
    ├── AttendeesView.swift
    ├── Event
    │   ├── CreateEventView.swift
    │   ├── EventDetail.swift
    │   ├── EventList.swift
    │   ├── EventRow.swift
    │   └── EventView.swift
    ├── General
    │   ├── Login.swift
    │   └── Settings.swift
    ├── RegisteredView.swift
    ├── Tables
    │   ├── TableList.swift
    │   ├── TablePlan.swift
    │   ├── TablePlan2.swift
    │   ├── TableRow.swift
    │   └── TablesView.swift
    ├── WaitingList
    │   ├── AttendeesAlignement.swift
    │   └── WaitingList.swift
    ├── newAttendee
    │   ├── NewAttendeeList.swift
    │   └── NewAttendeeRow.swift
    └── register
        ├── RegisteredDetail.swift
        ├── RegisteredList.swift
        └── RegisteredRow.swift
```
