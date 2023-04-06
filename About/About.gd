extends Node2D


onready var window = get_node("Window")
onready var text = get_node("Window/ScrollContainer/Label")
var essay = """
American Democracy: a work in progress

To summarize gerrmandering in one sentence:
If party wins the state legislature, most states 
will see their congressional districts redrawn to 
favor the makeup of their local governments, 
whether that be Democrat or Republican. 

Gerrymandering has been cited by authors such 
as Yascha Mounk as overtly undemocratic. Two 
things are keeping Gerrymandering around. 
First, the fact that most people don’t know what 
it is, and second, the lack of a better alternative. 
So first, why is Gerrymandering even a thing?

In the early days of American Independence, 
Democracy was in an experimental stage. 
Modeling a new country on a republic that ended 
1800 years ago was not a simple task. The founding 
fathers were well educated and knowledgeable 
about political philosophy of the day. For example, 
the three branches of government were created to 
put in place a system of checks and balances, an 
idea that dates back to Ancient Rome. Several 
states, such as New Jersey, originally used an 
“at-large” voting system, meaning members of a governing body were elected by popular vote. In this system, each voter (as long as they were, male, white and owned land) had the same number of votes and could use them to support multiple candidates running for office. However, this led to the entire state being dominated by one political party. Sometimes, a community preferred another candidate, but far across the expanse of the state, another community simply had more people. Many people felt unrepresented. 
A solution that helped fix this problem was to split the state into districts—shapes intended to represent a political area—however, the method for drawing them and how often to do it was still unclear. The constitution says that representatives are assigned to a state based on that state’s population, but the founding fathers left the process of choosing those representatives up to the states. Gerrymandering was invented out of earnest attempts at redesigning the voting system to be fair.
In the early 19th century, Congress continually passed laws to try and improve the fairness of the system, but in this regard, they were writing laws for themselves. The solution that became the system we use today was to redraw the districts every decade. In some states elected representatives draw them. In others, they are drawn by an independent commission. It turns out, democracy is more complicated than “one person, one vote.”
	The public resentment of Gerrymandering was apparent from its outset, when Elbridge Gerry, former vice president under James Madison, drew the districts as the governor of Massachusetts. Gerry was concerned about the Federalist party winning too many seats, so he drew the districts of Massachusetts to favor The Democratic-Republican party. The editor of the Boston Gazette published a scathing article, The Gerrymander: a New Species of Monster, criticizing Gerry's tactic. The article featured a political cartoon with Gerry's district stylized to look like a monstrous Salamander-Dragon. The editor warned Massachusans and Americans, "Behold and shudder at the exhibition of this terrific dragon, brought forth to swallow and devour your liberties and equal Rights."
One suggested solution is to let a computer algorithm draw the districts, based on a mathematical principle of fairness. However, algorithms, even if perfectly fair in theory, might not be able to understand the boundaries of communities. There is also a sense of uneasiness created by letting a black-box make such important decisions. Just as important as fair democracy, is the appearance of fairness. People want to feel represented by a member of their community, not a computer algorithm. Also, computer algorithms are not necessarily free of bias.
Gerrymandering hurts Republicans and Democrats alike. The great tragedy of gerrymandering is that most Americans don’t get to live in a district represented by a congressperson who supports their values. Because of the gerrymandering strategy, some places are unanimous in their support for one candidate but their party is a minority in the state, while other districts are carefully split so that a party wins by the smallest possible margin. Case and point is Colorado’s District 3. Redistricted in 2021 by a Republican state house, Lauren Boebert won her district by 0.1%, or about 500 votes. She rode in on a short-lived populist wave, but thanks to Gerrymandering, she may represent her unwilling 49.9% for the rest of their lives.
	There is no consensus around an alternate method, but the constitution gives congress the power to ban gerrymandering.
"""


func _ready():
	window.set_title("About Gerrymandering")
	window.set_width(1000)
	#text.text = essay
