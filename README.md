# CloudGoat: vulnerable Cognito

[CloudGoat](https://github.com/RhinoSecurityLabs/cloudgoat) by Rhino Security Labs: "vulnerable by
design" AWS deployment scenarios. This repository runs its `vulnerable_cognito` scenario with
[Isoloom](https://www.isoloom.com) in your own AWS account: [`isoloom.yml`](isoloom.yml) describes
the cloud services, the scenario sits unchanged in
[`app/`](app), and [`terraform/`](terraform) is a small wrapper that
feeds the scenario what CloudGoat's Python CLI would.

| Cloud services | What |
| --- | --- |
| Cognito | A user pool and an identity pool |
| API Gateway | The sign-up and login pages served from S3 |
| Lambda | A pre-sign-up trigger |

Cost while it runs: Cognito, API Gateway, Lambda and S3, billed per request (well under $0.01 an hour idle).

## Run it

Use an AWS account with nothing else in it, signed in with the AWS CLI (`aws login`, the
`default` profile, or set another with `-s cloud.vars.profile=<name>`), and Terraform installed.

```bash
isoloom run cloud-services
isoloom test cloud-services
isoloom down cloud-services
```

`run` prints where to start (your starting credentials, if the scenario gives you some). Guide:
the scenario's [README](app/cloudgoat/scenarios/aws/vulnerable_cognito/README.md) and cheat sheets in [`app/cloudgoat/scenarios/aws/vulnerable_cognito/`](app/cloudgoat/scenarios/aws/vulnerable_cognito).
Anything you create yourself while playing isn't Terraform's: delete it before `down`.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

BSD-3-Clause, as CloudGoat ([LICENSE](LICENSE)). This lab is deliberately vulnerable: deploy it
only in an account you use for nothing else, and destroy it when you are done.
