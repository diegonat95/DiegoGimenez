// Choose the number to guess in the line below or use the random number generator
//numberToGuess := 4
numberToGuess := (Random value( 99 ) + 1) floor()

countGuesses := 0
pastNumber := nil
currentNumber := nil
"You have ten tries to guess a number from 1 to 100"

while(countGuesses < 10,
  countGuesses = countGuesses + 1
  countGuesses print
  currentGuess := File standardInput readLine(") Enter your guess: ") asNumber()
  currentNumber = currentGuess

  if(currentNumber == numberToGuess) then (
    countGuesses = 11
    "That's right, congrats!" println
  )

  if (currentNumber < numberToGuess) then("Higher" println) elseif(currentNumber > numberToGuess) then ("Lower" println)
    pastNumber = currentNumber
  )

  if (countGuesses == 10) then ("You run out of guesses. Sorry!" println)
