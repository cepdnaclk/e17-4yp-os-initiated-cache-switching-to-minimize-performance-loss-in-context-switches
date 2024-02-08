
int main() {

  int i, n;

  // initialize first and second terms
  int t1 = 0, t2 = 1;

  // initialize the next term (3rd term)
  int nextTerm = t1 + t2;

  n=20;

  // print the first two terms t1 and t2
  //printf("Fibonacci Series: %d, %d, ", t1, t2);

  // print 3rd to nth terms
  for (i = 3; i < n+1; ++i) {
    // printf("%d, ", nextTerm);
    t1 = t2;
    t2 = nextTerm;
    nextTerm = t1 + t2;
  }

//printf("%d", nextTerm);

  return 0;
}


"
mem(40) => t2
mem(32)  => t1
mem(36) => nextTerm

mem(44)  => i
mem(28)   => n	//not change 48
"