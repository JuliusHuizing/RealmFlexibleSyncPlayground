# General feedback on flex sync 
* I'm a beginner wrt using databases and developing mobile applications. Chose realm over firebase because of realm sync and Realm's offline-first fn + how well it seemed to integrate with SwiftUI.
* Would love more examples / best practices in the docs.
* Happily found that andrew had a branch of rchat with flex sync enabled, but do not think the docs refer to this.
  * Do think RChat can also be a bit diffcult to grasp, since it also uses a lot more advanced swift features like notifications etc, making it more challenging to find the code that matters to understand realm sync. I.e. I would say there might be too big a gap between the task tracker app and the Rchat app and would prefer if there were also intermediate tutorials/examples.

# Questions / problems:
## All problems below can be reproduced with this repo: https://github.com/JuliusHuizing/RealmFlexibleSyncPlayground
### (There are TODO's in the swift code pointing to where the problems occur)
* What is a proper way to start with a clean sheet on both the client and the server side? Now I do:
  * delete associated atlas collections in atltas FE
  * remove app users using realmcli
  * remove schemas in realm FE
  * Terminate and restart sync
  * reset and erase contents from simulator
  * -> However, when I do this, it often takes very long (15+ min) for the first freshly registered user to be retrieved from the Realm again, although I can see the user is present in the atlas db. This happens for me on both a shared and a dedicated cluster.
* At some point, Xcode's preview no longer seems to work when using Realm.
* There is some unexpected behavior when trying to edit/view just created realm objects (see TODO in DailyDiaryView in repo.)
  

# Findings:
* When trying to write to a new created persistable class (e.g UserPost in provided repo), I found the error in the Realm ui/cli logs "ending session with error: integrating changesets failed: write failed: table "<TYPE>" has no permissions defined (ProtocolErrorCode=201)" very confusing: I spent a few hours trying to define the permissions in the sync page on on the Realm UI hoping to solve the problem, only to find out the problem was that I was trying to write to a collection that I hadn't set a subscription for on the client side yet.
## The following behaviors can be reproduced with the code in https://github.com/JuliusHuizing/RealmFlexibleSyncPlayground
* An @ObservedResults(Type.self) is initially populated by setting a subscription to that type. Afterwards, all subsequent views that define an @Observedresults of that type again can access the same instances of that type, even if the views do not create new subs to the type themselves. Even more so, if another view does add a sub to that type, the results in the @obeservedresults var will accumulate. I.e an @observedresults of a particular type will always be the UNION of all sub results for that type, even if those subs happen in different views than the particular observedresults you are viewing. This was not obious to me at first. Also see green colored overlay view in HomeView in repo.
* When you create a view with observedresults and set a sub when that view appears, the @observedresults will actually not be populated with results until there is a view in the view that makes use of its results. This was not obious to me at first either. 
* It can be very useful to in Xcode use the device -> reset and erase all content on your ios simulator to fix sync problems.


