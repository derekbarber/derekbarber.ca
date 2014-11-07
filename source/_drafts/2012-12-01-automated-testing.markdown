---
layout: post
title: "Automated Testing Overview"
date: 2012-10-26 16:57
comments: true
sharing: true
published: false
categories: [musings]
---

I am a PHP programmer and I am new to testing. What is the difference between unit, functional, acceptance, and integration testing? (and any other types of tests that I failed to mention)

Depending on where you look, you'll get slightly different answers. I've read about the subject a lot, and here's my distillation; again, these are slightly wooly and others may disagree.

Unit Tests

Tests the smallest unit of functionality, typically a method/function (e.g. given a class with a particular state, calling x method on the class should cause y to happen). Unit tests should be focussed on one particular feature (e.g., calling the pop method when the stack is empty should throw an InvalidOperationException). Everything it touches should be done in memory; this means that the test code and the code under test shouldn't:

Call out into (non-trivial) collaborators
Access the network
Hit a database
Use the file system
Spin up a thread
etc.
Any kind of dependency that is hard to understand / initialise / manipulate should be stubbed/mocked/whatevered using the appropriate techniques so you can focus on what the unit of code is doing, not what its dependencies do.

In short, unit tests are as simple as possible, easy to debug, reliable (due to reduced external factors), fast to execute and help to prove that the smallest building blocks of your program function as intended before they're put together. The caveat is that, although you can prove they work perfectly in isolation, the units of code may blow up when combined which brings us to ...

Integration Tests

Integration tests build on unit tests by combining the units of code and testing the resulting combination. This can be either the innards of one system, or combining multiple systems together to do something useful. Also, another thing that differentiates integration tests from unit tests is the environment. Integration tests can and will use threads, access the database or do whatever is required to ensure that all of the code and the different environment changes will work correctly.

If you've built some serialization code and unit tested its innards without touching the disk, how do you know that it'll work when you are loading and saving to disk? Maybe you forgot to flush and dispose filestreams. Maybe your file permissions are incorrect and you've tested the innards using in memory streams. The only way to find out for sure is to test it 'for real' using an environment that is closest to production.

The main advantage is that they will find bugs that unit tests can't such as wiring bugs (e.g. an instance of class A unexpectedly receives a null instance of B) and environment bugs (it runs fine on my single-CPU machine, but my colleague's 4 core machine can't pass the tests). The main disadvantage is that integration tests touch more code, are less reliable, failures are harder to diagnose and the tests are harder to maintain.

Also, integration tests don't necessarily prove that a complete feature works. The user may not care about the internal details of my programs, but I do!

Functional & Acceptance Tests

Functional tests usually check a particular feature for correctness by comparing the results for a given input against the specification. Functional tests don't concern themselves with intermediate results or program state (they don't care that after doing x, object y has state z), they are written to test specified behaviour such as, "when the user clicks the magnifying glass button on the side bar, the document is magnified by 25%". It's basically like dropping a coin through a hole in a box and watching to see if something drops from the other end. It either works or it doesn't.

An acceptance test is a particular type of functional test. Acceptance tests are created to mirror the user stories created by/for the software's customer. If the acceptance tests all pass, it means the software should meet all of the user's requirements. An acceptance test suite is basically an executable specification.

The advantage is that the tests are described in plain English and ensures the software, as a whole, is feature complete. The disadvantage is that you've moved another level up the testing pyramid. Functional/Acceptance tests touch mountains of code, so tracking down a failure can be tricky.

Conclusion

They're all complementary. Sometimes it's advantageous to focus on one type or to eschew them entirely. The main difference for me is that some of the tests look at things from a programmer's perspective, whereas others use a customer/end user focus.

http://en.wikipedia.org/wiki/Unit_Test
http://en.wikipedia.org/wiki/Functional_test
http://en.wikipedia.org/wiki/Acceptance_test
http://en.wikipedia.org/wiki/Integration_test
