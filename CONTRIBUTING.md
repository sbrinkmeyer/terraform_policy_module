# How to Contribute
Much of this document was inspired by Puppetlabs' [fabulous example](https://github.com/puppetlabs/puppet/blob/master/CONTRIBUTING.md).


## Getting Started

* Make sure you have access to [JIRA](https://jira.business.com).
* Make sure you have access to [GitHub Enterprise](https://github.business.com/).
* Submit a Jira ticket for your issue if one does not already exist.
  * Clearly describe the issue including steps to reproduce when it is a bug.
  * Make sure you fill in the earliest version that you know has the issue.
* Make sure you have you own [namespace](https://confluence.business.com/display/CAT/Hackenv+Namespaces), or access to a test namespace
* Clone the repository

## Making Changes

* Create a topic branch from where you want to base your work.
  * This is usually the master branch.
* Make commits of logical and atomic units.
* Check for unnecessary whitespace with `git diff --check` before committing.
* Make sure your commit messages are in the proper format. If the commit
  addresses an issue filed in the
  [CAT Jira project](https://jira.business.com/projects/CAT/issues), start
  the first line of the commit with the issue number in parentheses.
```
    (CAT-1234) Make the example in CONTRIBUTING imperative and concrete

    Without this patch applied the example commit message in the CONTRIBUTING
    document is not a concrete example. This is a problem because the
    contributor is left to imagine what the commit message should look like
    based on a description rather than an example. This patch fixes the
    problem by making the example concrete and imperative.

    The first line is a real-life imperative statement with a ticket number
    from our issue tracker. The body describes the behavior without the patch,
    why this is a problem, and how the patch fixes the problem when applied.
```
* Check syntax and test code correctness with `terraform fmt` and `terraform validate`
* Test the changes in a namespace by pinning the namespace's module source to your branch and running the jenkins job.
* *YOU MUST* create a md containing information on how to use the policy

## Submitting Changes

* Push your changes to a topic branch in the repository.
* Submit a pull request to the repository.
  * Add the `cat-terraform/reviewers` group as reviewers
* Update your Jira ticket to mark that you have submitted code and are ready for it to be reviewed.
  * Include a link to the pull request in the ticket.
  * Include the method used to test and the results. For example, when making a console-based change, include before-and-after screenshots showing the desired behavior change.


## Additional Resources

* https://confluence.business.com/display/CAT/Managing+Tenant+IAM+Roles+and+Policies
* https://confluence.business.com/display/CAT/Hackenv+Namespaces
* [General Github Documentation](https://help.github.com/)