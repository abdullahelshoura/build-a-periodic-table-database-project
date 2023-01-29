#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#print a message while there is no input given
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #check if the input not number
  if [[ $((1)) != $1 ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")   
  else
    #here the input is number
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  fi
  #if element not existt
  if [[ -z $ELEMENT_INFO ]]
  then
    echo "I could not find that element in the database."
  else
   echo "$ELEMENT_INFO" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
   do 
    echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed -r 's/^ *| *$//g') is $(echo $NAME | sed -r 's/^ *| *$//g') ($(echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $ATOMIC_MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $MELT_POINT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BOIL_POINT | sed -r 's/^ *| *$//g') celsius."
   done
  fi

fi
