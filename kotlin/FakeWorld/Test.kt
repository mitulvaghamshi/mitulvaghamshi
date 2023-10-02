package test

import src.models.Elf
import src.models.Fighter
import src.models.Hobbit
import src.models.Human
import src.models.Wizard

/**
 * A static method to test the program it will create and
 * check whether all the classes working correctly or not.
 */
fun main() {
    println("\n*** Welcome to the town of Hogsface in the magical land of Foon ***\n")
    println("Create two new Hobbits...")
    val hobbit1 = Hobbit("Frodo")
    val hobbit2 = Hobbit("Samwise", 8, 12, 2, 14, 10, 30)
    println(hobbit1)
    println(hobbit2)
    println("\nCreate two new Elves...")
    val elf1 = Elf("Legolas")
    val elf2 = Elf("Elrond", 14, 20, 18, 12, 1000, 80, "Forest", hobbit1)
    println(elf1)
    println(elf2)
    println("\nCreate two new Humans...")
    val human1 = Human("Aragorn")
    val human2 = Human("Wormtongue", 100, 12, 2, 16, 100, 50, elf2)
    println(human1)
    println(human2)
    System.out.printf("\n%s attacks %s! \n", elf2.name, human2.name)
    elf2.attack(human2)
    println(human2)
    System.out.printf("\n%s steals from %s!\n", hobbit1.name, human2.name)
    hobbit1.stealFrom(human2)
    println(hobbit1)
    println(human2)
    System.out.printf("\n%s changes his best friend!\n", elf2.name)
    elf2.friendOf(hobbit2)
    println(elf2)
    println("\nCreate two new Fighters...")
    val fighter1 = Fighter("Boromir")
    val fighter2 = Fighter("Faramir", 18, 15, 3, 8, 150, 55, elf1)
    println(fighter1)
    println(fighter2)
    System.out.printf("\n%s attacks %s!\n", fighter1.name, hobbit1.name)
    fighter1.attack(hobbit1)
    println(hobbit1)
    println("\nCreate two Wizards...")
    val wizard1 = Wizard("Gandalf")
    val wizard2 = Wizard("Saruman", 8, 12, 4, 15, 2500, 90, elf1, 20)
    println(wizard1)
    println(wizard2)
    System.out.printf("\n%s heals %s!\n", wizard1.name, hobbit1.name)
    wizard1.healTo(hobbit1)
    println(wizard1)
    println(hobbit1)
    System.out.printf("\n%s attacks themselves (but not really)!\n", fighter1.name)
    println(fighter1)
    fighter1.attack(fighter1)
    println(fighter1)
}
