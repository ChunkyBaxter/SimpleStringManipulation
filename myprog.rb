#!/usr/bin/env ruby

#Todo:
#    refactor, refactor, refactor since this is a quick "get it done" approach

# Program intro and user instruction part
puts "MIMvista Program"
puts "Please enter in your strings. End a string with the ENTER key"
puts "End string input by entering -quit\n\n"

# functions used in input manipulation
def reverseIfMultipleOf4(userString)
  if userString.length % 4 == 0
    userString = userString.reverse
  end
  return userString
end

def truncateIfMultipleOf5(userString)
  if userString.length % 5 == 0
    userString = userString[0,5]
  end
  return userString
end

def toUppercaseIfFirst5CharscontainMoreThan2UppercaseLetters(userString)
  testString = userString[0,5]
  if testString.count("A-Z") >= 3
    userString = userString.upcase
  end
  return userString
end

def lineTransforms(userString)
  userString = reverseIfMultipleOf4(userString)
  userString = truncateIfMultipleOf5(userString)
  userString = toUppercaseIfFirst5CharscontainMoreThan2UppercaseLetters(userString)
  
  return userString
end

def hyphenFound(userString)
  if userString[userString.length-1] == "-"
    return true
  else
    return false
  end
end

def hyphenMeansConcatinatingPreviousStringWithNextString(mimArray, newMIMArray, index)
  returnString = ""
  
  if index > 0 and index < (mimArray.count - 1) then

    previousString = newMIMArray[newMIMArray.count - 1]
    currentString = mimArray[index]
    nextString = mimArray[index +1]

    if hyphenFound(currentString)
      returnString = previousString + nextString
    end
  end
  return returnString
end

# User input gathering
mimArray = Array.new
userEntry = gets.chomp
while userEntry != "-quit"
  mimArray.push(userEntry)
  userEntry = gets.chomp
end

# Input manipulation part
newMIMArray = Array.new
for index in (0..mimArray.count-1) do
  tempString = mimArray[index]
  if hyphenFound(tempString) == false
    tempString = lineTransforms(tempString)
    newMIMArray.push(tempString)
  else
    tempString = hyphenMeansConcatinatingPreviousStringWithNextString(mimArray,newMIMArray, index)
    if tempString != ""
      newMIMArray[index-1] = tempString
    end
  end
  puts "#{tempString}"
end


# Creating output metrics
inputCharacterSum = 0
originalMedianArray = Array.new
mimArray.each do |inputLine|
  inputCharacterSum += inputLine.length
  originalMedianArray.push(inputLine.length)
end
originalMedianArray.sort!

outputCharacterSum = 0
modifiedMedianArray = Array.new
newMIMArray.each do |outputLine|
  outputCharacterSum += outputLine.length
  modifiedMedianArray.push(outputLine.length)
end
modifiedMedianArray.sort!

puts "\nOriginal input:\n#{mimArray}"
puts "Numbers of characters in original input: #{inputCharacterSum}"
if originalMedianArray.length.even?
  puts "The original lists median is either #{originalMedianArray[originalMedianArray.length / 2 - 1]} or #{originalMedianArray[originalMedianArray.length / 2]}"
else
  puts "The original lists median is #{originalMedianArray[originalMedianArray.length / 2]}"
end
puts "\n"
puts "Modified input:\n#{newMIMArray}"
puts "Numbers of characters in modified output: #{outputCharacterSum}"
if modifiedMedianArray.length.even?
  puts "The modified lists median is either #{modifiedMedianArray[modifiedMedianArray.length / 2 - 1]} or #{modifiedMedianArray[modifiedMedianArray.length / 2]}"
else
  puts "The modified lists median is #{modifiedMedianArray[modifiedMedianArray.length / 2]}"
end