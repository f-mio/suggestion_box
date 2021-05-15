class FilterScore < ActiveHash::Base
  self.data = [
    {id: 0, name: "---"},
    {id: 1, name: "未評価"},
    {id: 10, name: "10以上"},
    {id: 20, name: "20以上"},
    {id: 30, name: "30以上"},
    {id: 40, name: "40以上"},
    {id: 50, name: "50以上"},
    {id: 60, name: "60以上"},
    {id: 70, name: "70以上"},
    {id: 80, name: "80以上"},
    {id: 90, name: "90以上"},
    {id: 100,name: "100点"},
  ]

end