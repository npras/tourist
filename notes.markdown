## Each route as an Object hypothesis

### Route1
From: A
To:   B
Dep:  aa:00
Arr:  bb:00
TimeTaken: 10.0
Price: 100.0

### Route2
From: B
To:   Z
Dep:  xx:00
Arr:  yy:00
TimeTaken: 50.0
Price: 200.0

### Route3
From: B
To:   C
Dep:  xx:00
Arr:  yy:00
TimeTaken: 40.0
Price: 300.0

# Given R1 and R2, get me a route from A to Z
### Resulting Route
From: A
To: Z
Dep: aa:00
Arr: yy:00
TimeTaken: 60.0
Price: 300.0

# Given R1, R2, and R3, get me the cheapest route from X to Y
### Resulting Route
From: X
To: Y
Dep:
Arr:
TimeTaken:
Price: 40.0
