---
layout: post
title: "Why test-driven development?"
date: 2012-03-27 10:30
comments: true
categories: [tdd, programming]
sharing: true
published: true
---

Perhaps you've heard of test-driven development but don't really know what it is. Or maybe you know about it but you just don't know why you would ever want to use it. In this article I hope to give an overview of exactly what test-driven development is and why you should consider integrating it into your software development process.

It is important to note that Test-driven development (TDD) is not solely a testing technique, but rather part of a holistic design, development and testing process. The basic idea of TDD is that instead of writing your code first and then writing tests after to ensure the code works, you write your tests first and then write the code that will get all the tests to pass. This is known as a *Test-First* approach.

There are two generally accepted views on how and why you should practice TDD in your software development. The first view sees TDD as a technique for specifying your requirements and design before writing the actual program code. The second view takes a more pragmatic approach and sees TDD as a technique that helps programmers write better code. Regardless of the view one takes, what TDD practitioners all agree on is that TDD will not only improve your code, but it will also improve the overall design and implementation of your software system.

<!-- more -->

## History of TDD

Generally, the modern "rediscovery"” of TDD is attributed to Kent Beck, who is also known as the creator of Extreme Programming. It was through both the Extreme Programming and Agile software development movements that TDD came to be widely accepted in the software development community.

It is said that Kent Beck "rediscovered" TDD since a prototype of TDD dates back to the early days of computing in the 1960s.  During the mainframe era when program code would be entered onto punch cards, programmers had limited time with the machine and thus would need to maximize the time they had. One documented practice was to write the expected output of whatever operation you were doing before entering the punch cards into the computer. Then when the mainframe would output the results of your program, you could immediately see whether the results you got were correct by comparing the actual output with the expected output that had been documented earlier.

The big difference between modern TDD and those early days is that it used to be a completely manual testing process, whereas the re-birth of TDD in recent years was facilitated due to automated testing. Today TDD refers solely to automated test-driven development.

Modern TDD was first practiced in the Smalltalk community and they used the Smalltalk SUnit suite for their automated testing. However, the Smalltalk community was always quite a small group and while influential, it took years for much of their brilliance to reach the wider industry. Additionally, since Smalltalk never really took off, that also hampered the initial spread of TDD.

It was in the Java community that TDD really started to take off thanks to the JUnit tool. JUnit was a port of SUnit written by Kent Beck and a couple others, and it brought automated testing to Java. At this time, many Java developers who were practicing either Agile or Extreme programming methodologies began to embrace TDD thanks to JUnit. Since then, a class of tools known as XUnit have been created for almost every programming language from PHP, Ruby, Python to JavaScript. Today, regardless of the programming language you are using, you should be able to find the tools and resources to implement TDD as part of your software development process.

### The Agile Manifesto

The Agile Manifesto is considered to be a very important milestone in modern software development and it was from this document that the term *Agile Software Development* was born. Many cutting-edge programming techniques such as Extreme Programming, Scrum, pair programming and refactoring have come the agile software community.

The Agile Manifesto is also an important milestone in the development of TDD as several of the key principles in the manifesto are the cornerstones of TDD. Some of these ideas are captured in the following quotes that are from the article [Principle behind the Agile Manifesto][1]:

 *  "Welcome changing requirements, even late in development. Agile processes harness change for the customer’s competitive advantage."
 *  "Deliver working software frequently, from a couple of weeks to a couple of months, with a preference to the shorter timescale."
 *  "Continuous attention to technical excellence and good design enhances agility."
 *  "Working software is the primary measure of progress."

It is these and other principles of the agile software movement that are truly realized through test-driven development. TDD helps software developers to manage and even welcome changing requirements, allowing them to quickly adapt their code as needed. TDD helps to deliver working software frequently as developers write their tests and then quickly write code that gets the tests to pass. TDD helps with a continuous attention to technical excellent and good design, as it forces developers to carefully plan and think through their design before writing any code. Finally, TDD helps to deliver working software, which is really the primary measure of progress on a software development project. TDD produces software that works.

## The TDD Process

It is helpful to now take a careful look at exactly how the test-driven process works. Exactly how does a developer begin to embrace and implement a TDD process in their workflow?

#### Step One: Write a failing test

A TDD practitioner begins by extracting a specific function from the system requirements. Once a specific function has been determined, the developer then writes an automated test that will test that specific function. The developer writes the test and then will write the minimal amount of code required in order for the test to simply run. Of course since the actual functionality has not been developed, the test will initially fail. This initial failure of the test is a key aspect of TDD and it is how each test begins.

#### Step Two: Write the code so the test passes

Once a failing automated test is completed, the developer can now write the code to implement the function. As the developer works on the code they can execute the automated test at any time to see if their code is working. This gives the developer immediate feedback and is part of the reason why TDD improves programmer productivity. The developer continues to work on their code until their automated test is passing. Once the test is passing the programmer can know with confidence that his code works as it should.

#### Step Three: Refactor (if necessary)

Refactoring is covered in detail below, however it is mentioned here as once a test is passing, the code is ready to be be refactored as needed. Now, this is not always a required step at this time, however some programmers will try to quickly get a test working and may in the process write some sloppy code. If that is the case, once the test is passing, the developer should go back and refactor their code so that is implemented properly with good design. Throughout the refactoring process, the developer can re-run the automated tests to make sure that they have not broken the required functionality.

#### Step Four: Repeat

Once the programmer has a test that is passing and they have clean and refactored code, they can then move on to the next function and proceed in the same manner. As the programmer progresses through all the required functions of the application, they will ultimately develop the actual working application. A real benefit of TDD comes with this, as they will simultaneously be completing a full test suite for the application with complete test coverage. It is very rare that a programmer will go back to their code and write tests for everything after having a fully implemented application. Complete test suite code coverage is simply a natural by-product of the TDD process and it is one that should not be underestimated.

### Refactoring

As mentioned above, refactoring is a part of the TDD process and is in fact a key advantage to TDD. This is because refactoring requires code that has complete test coverage and so when a programmer is following TDD, all their code will always meet this requirement.

Code refactoring is essentially a restructuring of an existing body of code in order to improve the underlying structure and design of the code. When you refactor, you don’t change or add any functionality, rather you want the code to produce the exact same behaviour as it did before refactoring. This is why complete test coverage is required before refactoring, since the tests will ensure that the functionality does not change and still works exactly as required.

A developer can refactor a method or function and throughout the process, they can re-run the automated tests to ensure that the behaviour of the code is still working as expected and that the tests are all passing. This gives a developer great confidence to go in and refactor code that they might otherwise avoid since without the tests, you never will know if the changes you are making have broken anything.

### Traditional and Test-Driven Development Compared

The following flowcharts show the primary differences between traditional and test-driven development processes. Both of these charts are largely based upon diagrams that are found in the [Impact of Using Test-Driven Development: A Case Study][4] and [Test driven development: empirical body of evidence][2] papers, which are shown under Resources.

{% img /images/tdd-flowcharts.png 700 877 "TDD Contrasted" %}

As the above diagrams show, the key difference between the two approaches is simply the test first nature of TDD. In the traditional process, you don’t write your tests until after completing the full implementation. Thus, testing is primarily a verification that the code works as intended; it doesn’t help the developer in their work. Since TDD starts with testing and incorporates testing as a part of the development process, the tests actually help the developer and will generally improve the quality and design of the code.


## A word on automated Testing

The foundation of test-driven development is automated testing, since without it, TDD would not be possible. In order to understand TDD, it is critical to also have a good understanding of automated testing. There are three main types of automated testing that are generally performed and these tests are written and executed by the actual developers. There may also be other types of automated testing but these three are some primary ones that developers will be working with.

 *  **Unit Testing**: Unit testing works as the name implies, it allows for the testing of individual units of code. Typically a unit test is written in order to execute a specific method or function within a class or modules of code. The main goal in unit testing is to ensure that each individual unit of code is executing as specified in the system requirements.
 *  **Integration Testing**: Integration testing is the logical progression from unit testing and it seeks to test multiple units and ensure that the units are able to produce the desired functionality when they are all brought together. An integration test will generally mirror an actual use case and it will ensure that all the underlying units are working together to produce the expected result of that use case.
 *  **Performance Testing**: with performance testing you typically seek to simulate a real-world usage scenario where you have a large number of users accessing and using the application simultaneously. Automated performance testing will use various tools to simulate such user behaviour and it ensures that the system can still perform under varying degrees of load.

With TDD, the primary focus of the developer will be on first writing Unit Tests and then writing Integration Tests. This is because both of these tests are built around the system requirements and ensure that each function works as intended both in isolation and then when integrated into the whole system. Performance testing is generally not included as a part of TDD but depending upon the application, it may also be included. Performance testing would be applicable when the performance of the system is itself a feature of the application.

## Benefits of TDD

The benefits of using TDD are wide reaching and very compelling. In the paper [Test driven development: empirical body of evidence][4], the following is stated, "TDD may help to improve software quality significantly, in terms of decreased fault rates, when employed in an industrial context." As this paper gathers and summarizes 13 empirical studies from the industry, this is quite a compelling conclusion that is backed by hard facts.

In an article entitled, [Does Test-Driven Development Really Improve Software Design Quality][3], the authors document how TDD contributes to better code. The article shows that code produced through TDD is generally better organized into smaller and well-designed units that are better tested. Such code not only is better from its initial release, but it is easier and less costly to maintain and adapt in the future.

Overall, you can find many articles and reports that list the many purported benefits of using a TDD process in your software development. Some of these benefits are as follows:

 *  Less software defects: since TDD produces code that is much more highly tested, the resulting software is generally shown to have fewer defects.
 *  Immediate feedback to the programmer: immediate feedback is given to the software developers during the TDD process so they can respond and change quickly. All a developer needs to do in order to find out if their code works is just run the tests.
 *  Increased confidence: since all the code is covered by tests that ensure it works as expected, developers have more confidence in their own code.
 *  Enables refactoring: since total test coverage is needed to refactor code, by doing TDD you are creating code that can easily be refactored.
 *  Cleaner and simpler designs: the code produced by TDD has been shown to be generally cleaner and simpler than code produced through a more traditional method. This ultimately produces code that is easier and less expensive to maintain.

Overall these are quite substantial benefits that should at the very least pique the interest of developers. Embracing a TDD process does require quite a radical shift in the thinking of developers but these benefits show that the effort required to do so is likely worth it.

## TDD Case Study

In the case study entitled [Impact of Using Test-Driven Development: A Case Study][4], we have the results of an experimental study that was done using undergraduate students at the University of Southern Mississippi. Each of these two groups consisted of 9 students and time period for the whole study was 3 months.

In this study, two groups of students were created; one group would develop software using a traditional approach of writing unit tests after developing the application. The other group would take a TDD approach and write their tests first and then implement the functionality of the application second. Both of these two groups developed the exact same software and both used an incremental and iterative approach. So, this study sought to determine whether the practice of TDD in a real software project resulted in better code and more productive programmers.

An additional SQA team was also utilized in the study and they were assigned the role of measuring the results of the study. This SQA team did subsequent additional unit testing, integration testing and acceptance testing of the software from each of the two development groups. Their work was done to measure the quality of the code produced by the two groups.

Some specific metrics were calculated for each of these two groups, which were used to help determine which development process was superior. These included the following:

 *  The number of test cases written
 *  The number of faults found by the SQA group in subsequent unit testing
 *  Number of faults recorded in subsequent integration testing
 *  Number of faults recorded during acceptance testing
 *  The total person hours for each group

*The following table of results can be found in the case study:*

<table>
  <tr>
    <th><strong>Metric</strong></th>
    <th><strong>TDD Approach</strong></th>
    <th><strong>Traditional Approach</strong></th>
  </tr>
  <tr>
    <td>Number of test cases written</td><td>629</td><td>211</td>
  </tr>
  <tr>
    <td>Number of faults detected by the SQA group during all the units tested</td><td>74</td><td>109</td>
  </tr>
  <tr>
    <td>Number of faults detected by the SQA group during integration testing</td><td>13</td><td>15</td>
  </tr>
  <tr>
    <td>Number of faults detected by the SQA group during acceptance testing</td><td>14</td><td>31</td>
  </tr>
  <tr>
    <td>Total Person Hours spent</td><td>928</td><td>1245</td>
  </tr>
</table>

The results of this case study are indeed compelling. While this is only one small case study, the results are consistent with other academic and industry studies. Clearly the TDD approach resulted in code that was much better tested, had fewer faults and ultimately took less time to write.

## Conclusion

In conclusion, I hope that this article has shown the very real benefits that can be gained from a test-driven development process. The industry results and case studies are quite conclusive; TDD has a very positive real and measurable benefit to software development projects.

I'm learning as I go here and so I would love to hear any feedback. Please get in touch if you have any questions or to let me know if I've gotten any details wrong.



[1]: http://agilemanifesto.org/principles.html "Principles behind the Agile Manifesto"

[2]: http://www.agile-itea.org/public/deliverables/ITEA-AGILE-D2.7_v1.0.pdf "Test driven development: empirical body of evidence"

[3]: http://digitalcommons.calpoly.edu/cgi/viewcontent.cgi?article=1027&context=csse_fac "Does Test-Driven Development Really Improve Software Design Quality"

[4]: http://ww1.ucmss.com/books/LFS/CSREA2006/SER4458.pdf "Impact of Using Test-Driven Development: A Case Study"


