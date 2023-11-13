___
# OS-Initiated Cache Switching to Minimize Performance Loss in Context Switches
Usually, accessing the main memory consumes a considerable amount of time. Therefore, the cache is placed between the main memory and the CPU to reduce memory access latency. Caches primarily rely on spatial and temporal locality to enhance data access speed.

Context switching is a method to share CPU time among multiple threads effectively. Context switching may result in invalidating cached content because, when a new thread is loaded, it may not have the same working set as the previous context. Therefore, the CPU has to access the main memory and load the relevant data block into the cache. This process places a considerable burden on the CPU, reducing its performance. As a solution, it is important to introduce a design that minimizes cache misses during context-switching.

In this project, we aim to introduce a cache bank instead of a single cache system to a RISC-V pipelined processor and measure the impact on the system performance compared to the single cache system. 


___



## Project Page
- [click here](https://cepdnaclk.github.io/e17-4yp-os-initiated-cache-switching-to-minimize-performance-loss-in-context-switches/)

## Other Pages
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [Faculty of Engineering](https://eng.pdn.ac.lk)
- [University of Peradeniya](https://www.pdn.ac.lk)


