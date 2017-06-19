# Dropdown Menu
Simple drop down component written in Swift 3

## Demo

![gif demo](https://media.giphy.com/media/3o7btTeAPZkr8shZkY/giphy.gif)

## Usage
1) Initialize 

```swift
 let names = ["Ada", "Brad", "Cathy", "Daniel", "Emily"]
 let frame = CGRectFromString("{{50,50},{100,40}}")
 //define frame of view, values to display, view to attach 
 let menuView = DropDownMenu(frame: frame, data: names, parentView: self.view) 
 //define delegate
 menuView.delegate = self 
````

2) Handle selected values in delegate
```swift
func menuItemSelected(sender: UIButton) {
  print(sender)
  print(self.names[sender.tag])
}
````

## Installation

* Clone repo
* Drop in the DropDownMenu.swift class into your project
* Integrate into your project programmatically or via Interface Builder

