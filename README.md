# it-support-toolkit

Simple toolkit for IT Support usage

Contains four tools for faster IT Support checkups on an faulty machine :

# System Information displayer : 

Shows the system's main features such as general info, OS edition (for now only windows), hardware, User intel, networks ands disks capacity and load.

## Development Workflow

During the initial development of the project, I was committing changes directly to the main branch.

I realized that, as the project grows, experimental changes could affect the stable version of the toolkit.

I therefore introduced a separate develop branch:

main: stable and tested versions

develop: ongoing development and testing

Stable changes will be merged from develop into main once they have been tested.

And, to remember my foolishness, this will be the last push of an untested and non-essential change directly to main.