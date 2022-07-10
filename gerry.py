#   You smart folx probaly did this in 3 lines, but here's my solution:
#
#   Find a hamiltonian path, 
#       cut it into fives, 
#       check and see if O wins, 
#       if not, check next permutation
#

import time
import random
import json

class Graph():
    def __init__(self, blocs, width):
        self.blocs = blocs
        s = width
        self.votes_needed_to_win = s // 2 + 1
        #a simple one liner converts the string into an ajacency matrix
        self.matrix = [[1 if (a==b+1 and (b+1)%s!=0) or a==b+s or (a==b-1 and ((b)%(s)!=0 or (b-1) == 0)) or a==b-s else 0 for a in range(s**2)] for b in range(s**2)]
        self.width = s
        self.size = s ** 2
        self.paths = []
        self.winning_path = None
        self.fair_map = None

    def check_for_condition(self, candidate, path, won=True):
        s = self.width
        districts = [path[x:x+s] for x in range(0, len(path), s)]

        election_results = [None]*s
        for i in range(len(districts)):
            local_election = 0
            for j in range(len(districts[0])):
                if self.blocs[districts[i][j]] == candidate:
                    local_election += 1
            if local_election >= self.votes_needed_to_win:
                election_results[i] = True
            else:
                election_results[i] = False

            count = election_results.count(not won)
            if count >= self.votes_needed_to_win:
                return not won

        return won

    def draw_fair_map(self):
        fair_map = ['-']*self.size
        d = 1
        i = 0
        for house in self.winning_path:
            fair_map[house] = str(d)
            if i >= self.width-1:
                i = 0
                d += 1
            else:
                i += 1
        self.fair_map = "".join([x for y in (fair_map[i:i+self.width] + ['\n'] * (i < len(fair_map) - 2) for
     i in range(0, len(fair_map), self.width)) for x in y][:-1])

    def can_visit(self, v, pos, path):
        p = self.matrix[ path[pos-1]][v] #path[pos-1] is connected to v
        if p == 0:
            return False
        if v in path: #and has not been visited
            return False
        return True

    def ham_util(self, path, pos):

        if pos == self.size:
            if path not in self.paths:
                if self.check_for_condition('O', path, won=True):
                    self.winning_path = path
                    self.draw_fair_map()
                else:
                    rotated_path = self.rotate_path(path)
                    if self.check_for_condition('O', rotated_path, won=True):
                        self.winning_path = rotated_path
                        self.draw_fair_map()
                self.paths.append(path)
                self.paths.append(self.rotate_path(path))
                return True
            else:
                return False
            

        for v in range(1, self.size):
            if self.can_visit(v, pos, path):
                path[pos] = v
                if self.ham_util(path, pos+1):
                    if self.winning_path:
                        return True
                    new_path = [x if ind<pos else -1 for ind, x in enumerate(path) ]
                    if self.can_visit(v, pos, new_path):
                        new_path[pos] = v
                        self.ham_util(new_path, pos+1)
                    return path
                path[pos] = -1

        return False

    def ham(self):
        path = [-1] * self.size
        path[0] = 0

        if not self.ham_util(path, 1):
            print("No solution")
            return False

        return self.winning_path

    def rotate_path(self, path):
        #a simple one liner rotates the path
        return [(value + (self.width-1)*(value%(self.width+1))) if 
                (value + (self.width-1)*(value%(self.width+1))) < self.size else 
                (value + (self.width-1)*(value%(self.width+1))) - self.size + 1 for value in path]

def gerrymander(G):
    width = len(G.split("\n"))
    G_matrix = list(G.replace("\n",""))
    g = Graph(G_matrix, width)
    g.ham()
    return(g.fair_map)

tests = {}
test_no = 0
def generate_random(size=5):
    
    result = ""
    for x in range(size):
        for y in range(size):
            if bool(random.getrandbits(1)):
                result+='O'
            else:
                result+='X'
        if x < size-1:
            result+='\n'
    print(result)
    print(".....")
    
    return result

if __name__ == "__main__":
    begin_time = time.time()
    #G = 'OOXXX\nOOXXX\nOOXXX\nOOXXX\nOOXXX'
    #print(gerrymander(G))
    use_json = True
    if use_json:
        with open("tests.json", 'r') as f:
            tests = json.loads(f.read())
    for n in range(25):
        start_time = time.time()
        print("-----")
        if not use_json:
            G = generate_random()
            tests[str(test_no)] = G
            test_no += 1
        else:
            print(tests[str(test_no)])
            print(".....")
            G = tests[str(test_no)]
            test_no += 1
        print(gerrymander(G))
        print("--- %s seconds ---" % (time.time() - start_time))
    print("Total: %s seconds ..." % (time.time() - begin_time))

    if not use_json:
        sentinel = input("Save tests? (y/n)")
        if sentinel.lower() == 'y':
            with open("tests.json", 'w') as f:
                f.write(json.dumps(tests))
    