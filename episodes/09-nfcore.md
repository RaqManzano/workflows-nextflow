---
title: "Deploying nf-core pipelines"
teaching: 20
exercises: 10
questions:
- "What is nf-core?"
- "What is nf-core tools?"
- "How do you find nf-core pipelines?"
- "How do you run nf-core pipelines?"
- "How do you configure nf-core pipelines?"
- "How do you use nf-core pipelines offline?"
objectives:
- "Understand what nf-core is and how it relates to Nextflow."
- "List, search and filter nf-core pipelines using the nf-core helper tool."
- "Run a test nf-core pipeline."
- "Understand how to configuration nf-core pipelines."
- "Understand how to download an nf-core pipelines offline."
keypoints:
- "nf-core is a community-led project to develop a set of best-practice pipelines built using the Nextflow workflow management system."
- "nf-core tools is a suite of helper tools that aims to help people run and develop pipelines."
- "nf-core pipelines can found using the nf-core helper tool --list option or from the nf-core website."
- "nf-core pipelines can be run using `nextflow run nf-core/<pipeline>` syntax, or launched and parameters configured using the nf-core  helper tool launch option."
- "nf-core pipelines can be configured by modifying nextflow config files and/or adding command line parameters."
---


## What is nf-core?

nf-core is a community-led project to develop a set of best-practice pipelines built using Nextflow workflow system.
Pipelines are governed by a set of guidelines, enforced by community code reviews and automatic code testing.


![nf-core](../fig/nf-core.png)


## What are nf-core pipelines?

nf-core pipelines are an organised folder containing Nextflow scripts,  other non-nextflow scripts (written in any language), configuration files, software specifications, and documentation hosted on GitHub. There is generally a single pipeline for a given data and analysis type e.g. There is a single pipeline for bulk RNA-Seq. All nf-core pipelines are distributed under the, permissive free software, [MIT licences](https://en.wikipedia.org/wiki/MIT_License).

### Software Packaging

nf-core pipelines define external software packaging using two files;

* `environment.yml`: conda environment file, list all software dependencies and versions.
* `Dockerfile`: A plain text file that contains all command line command used to assemble the image. Docker images are created using conda and the `environment.yml` file.

Due to reproducibility issues that conda environments sometimes have it is recommended to run the pipeline in a containerised fashion which can de done using docker or singularity containers. However, if you can't use software containers the dependencies can still be handled automatically using conda.

It is Nextflow that handles the downloading of containers and creation conda environments.

### CI Testing

Every time a change is made to the pipeline code, nf-core pipelines use continuous-integration testing to ensure that nothing has broken.

More info [here](https://nf-co.re/developers/guidelines).


### Pipeline template

Below is the nf-core pipeline template folder structure created using the nf-core helper tool `nf-core create` command.

~~~
nf-core-<pipeline>/
├── assets
│   ├── email_template.html
│   ├── email_template.txt
│   ├── multiqc_config.yaml
│   ├── nf-core-bioinf_logo.png
│   └── sendmail_template.txt
├── bin
│   ├── markdown_to_html.py
│   ├── __pycache__
│   │   ├── markdown_to_html.cpython-36.pyc
│   │   └── scrape_software_versions.cpython-36.pyc
│   └── scrape_software_versions.py
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── conf
│   ├── base.config
│   ├── igenomes.config
│   ├── test.config
│   └── test_full.config
├── Dockerfile
├── docs
│   ├── images
│   │   └── nf-core-bioinf_logo.png
│   ├── output.md
│   ├── README.md
│   └── usage.md
├── environment.yml
├── LICENSE
├── main.nf
├── nextflow.config
├── nextflow_schema.json
└── README.md
└── .github
│   └── ....truncated
~~~


## What is nf-core tools?

nf-core provides a suite of helper tools aim to help people run and develop pipelines.
The [nf-core tools](https://nf-co.re/tools) package is written in Python and can be imported and used within other packages.

> ## Automatic version check
> nf-core/tools automatically checks the web to see if there is a new version of nf-core/tools available. If you would
> prefer to skip this check, set the environment variable NFCORE_NO_VERSION_CHECK. For example:
>
>
> ~~~
> export NFCORE_NO_VERSION_CHECK=1
> ~~~
> {: .language-bash}
{: .callout}

### nf-core tools sub-commands

You can use the `--help` option to see the range of nf-core tools sub-commands.
In this episode we will be covering the `list`, `launch` and `download` sub-commands which
aid in the finding and deployment of the nf-core pipelines.

~~~
nf-core --help
~~~
{: .language-bash}


~~~
                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 1.13



Usage: nf-core [OPTIONS] COMMAND [ARGS]...

Options:
  --version                  Show the version and exit.
  -v, --verbose              Print verbose output to the console.
  -l, --log-file <filename>  Save a verbose log to a file.
  --help                     Show this message and exit.

Commands:
  list          List available nf-core pipelines with local info.
  launch        Launch a pipeline using a web GUI or command line prompts.
  download      Download a pipeline, nf-core/configs and pipeline...
  licences      List software licences for a given workflow.
  create        Create a new pipeline using the nf-core template.
  lint          Check pipeline code against nf-core guidelines.
  modules       Work with the nf-core/modules software wrappers.
  schema        Suite of tools for developers to manage pipeline schema.
  bump-version  Update nf-core pipeline version number.
  sync          Sync a pipeline TEMPLATE branch with the nf-core template.
~~~  
{: .output}

## Listing available nf-core pipelines

The simplest sub-command is `nf-core list`, which lists all available nf-core pipelines in the nf-core Github repository.

The output shows the latest version number and when that was released.
If the pipeline has been pulled locally using Nextflow, it tells you when that was and whether you have the latest version.

Run the command below.

~~~
nf-core list
~~~
{: .language-bash}

An example of the output from the command is as follows:

~~~


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 1.13



┏━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
┃ Pipeline Name     ┃ Stars ┃ Latest Release ┃      Released ┃    Last Pulled ┃ Have latest release? ┃
┡━━━━━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
│ eager             │    45 │          2.3.2 │     yesterday │              - │ -                    │
│ diaproteomics     │     5 │          1.2.2 │   3 weeks ago │              - │ -                    │
│ dualrnaseq        │     3 │          1.0.0 │  1 months ago │              - │ -                    │
│ mag               │    42 │          1.2.0 │  1 months ago │              - │ -                    │
│ ampliseq          │    54 │          1.2.0 │  1 months ago │              - │ -                    │
│ sarek             │    94 │            2.7 │  2 months ago │              - │ -                    │
│ cageseq           │     3 │          1.0.2 │  2 months ago │              - │ -                    │
[..truncated..]
~~~
{: .output}

### Filtering available nf-core pipelines

If you supply additional keywords after the list sub-command, the listed pipeline will be filtered. Note that this searches more than just the displayed output, including keywords and description text.

Here we filter on the keywords **rna** and **rna-seq** .

~~~
nf-core list rna rna-seq
~~~
{: .language-bash}

~~~

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 1.13



┏━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
┃ Pipeline Name ┃ Stars ┃ Latest Release ┃     Released ┃ Last Pulled ┃ Have latest release? ┃
┡━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
│ dualrnaseq    │     3 │          1.0.0 │ 1 months ago │           - │ -                    │
│ rnaseq        │   304 │            3.0 │ 3 months ago │           - │ -                    │
│ rnafusion     │    56 │          1.2.0 │ 8 months ago │           - │ -                    │
│ smrnaseq      │    18 │          1.0.0 │  1 years ago │           - │ -                    │
│ circrna       │     1 │            dev │            - │           - │ -                    │
│ lncpipe       │    18 │            dev │            - │           - │ -                    │
│ scflow        │     2 │            dev │            - │           - │ -                    │
└───────────────┴───────┴────────────────┴──────────────┴─────────────┴──────────────────────┘
~~~
{: .output}

### Sorting available nf-core pipelines

You can sort the results by latest release (`-s release`, default), when you last pulled a local copy (`-s pulled`), alphabetically (`-s name`), or number of GitHub stars (`-s stars`).
~~~
nf-core list rna rna-seq --sort stars
~~~
{: .language-bash}

~~~
                                      ,--./,-.
      ___     __   __   __   ___     /,-._.--~\
|\ | |__  __ /  ` /  \ |__) |__         }  {
| \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                      `._,._,'

nf-core/tools version 1.13



┏━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
┃ Pipeline Name ┃ Stars ┃ Latest Release ┃     Released ┃ Last Pulled ┃ Have latest release? ┃
┡━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
│ rnaseq        │   304 │            3.0 │ 3 months ago │           - │ -                    │
│ rnafusion     │    56 │          1.2.0 │ 8 months ago │           - │ -                    │
│ lncpipe       │    18 │            dev │            - │           - │ -                    │
│ smrnaseq      │    18 │          1.0.0 │  1 years ago │           - │ -                    │
│ dualrnaseq    │     3 │          1.0.0 │ 1 months ago │           - │ -                    │
│ scflow        │     2 │            dev │            - │           - │ -                    │
│ circrna       │     1 │            dev │            - │           - │ -                    │
└───────────────┴───────┴────────────────┴──────────────┴─────────────┴──────────────────────┘
~~~
{: .output}

To return results as JSON output for downstream use, use the `--json` flag.

> ## Archived pipelines
> Archived pipelines are not returned by default. To include them, use the `--show_archived` flag.
{: .callout}


> ## Exercise: listing pipelines
>
>   Use the `--help` flag to print the list command usage.
>
>   Sort all pipelines by popularity (stars).
>
>   Filter pipelines for those that work with RNA.
>
>   Have these pipeline details to a JSON file.
>
> > ## Solution
> >
> > ~~~
> > 1. `nf-core list --help`
> >
> > 2. `nf-core list --sort stars`
> >
> > 3. `nf-core list rna`
> >
> > 4. `nf-core list rna --json`
> > ~~~
> >
> {: .solution}
{: .challenge}

## Running nf-core pipelines

### Software requirements for nf-core pipelines

In order to run nf-core pipelines, you will need to have [Nextflow](https://www.nextflow.io) installed . The only other requirement is a software packaging tool: Conda, Docker or Singularity. In theory it is possible to run the pipelines with software installed by other methods (e.g. environment modules, or manual installation), but this is not recommended. Most people find either Docker or Singularity the best options.

### Fetching pipeline code

Unless you are actively developing pipeline code, you should use Nextflow's [built-in functionality](https://www.nextflow.io/docs/latest/sharing.html) to fetch nf-core pipelines. You can  use the command

~~~
nextflow pull nf-core/PIPELINE
~~~
{: .language-bash}

to pull the latest version of a remote workflow from the nf-core github site.

Nextflow will also automatically fetch the pipeline code when you run `nextflow run nf-core/<pipeline>`.

For the best reproducibility, it is good to explicitly reference the pipeline version number that you wish to use with the `-revision`/`-r` flag.

In the example below we are pulling the rnaseq pipeline version 3.0

~~~
nextflow pull nf-core/rnaseq -revision 3.0
~~~
{: .language-bash}

We can check the pipeline has been pulled using the `nf-core list` command.
~~~
nf-core list rnaseq -s pulled
~~~
{: .language-bash}


We can see from the output we have the latest release.

~~~
                                      ,--./,-.
      ___     __   __   __   ___     /,-._.--~\
|\ | |__  __ /  ` /  \ |__) |__         }  {
| \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                      `._,._,'

nf-core/tools version 1.13



┏━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
┃ Pipeline Name     ┃ Stars ┃ Latest Release ┃      Released ┃    Last Pulled ┃ Have latest release? ┃
┡━━━━━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
│ rnaseq            │   304 │            3.0 │  3 months ago │ 1 minutes ago │ Yes (v3.0)           │
[..truncated..]
~~~
{: .output}

If not specified, Nextflow will fetch the default branch. For pipelines with a stable release this the default branch is `master` - this branch contains code from the latest release. For pipelines in early development that don't have any releases, the default branch is `dev`.


> ## Exercise: Fetch the latest RNA-Seq pipeline
>
>  1. Use the `nextflow pull` command to download the latest `nf-core/rnaseq` pipeline
>
>  2. Use the `nf-core list` command to see if you have the latest version of the pipeline
>
> > ## Solution
> >
> > 1. `nextflow pull nf-core/rnaseq`
> >
> > 2. `nf-core list rnaseq -s pulled`
> >
> {: .solution}
{: .challenge}

# Usage instructions and documentation

You can find general documentation and instructions for Nextflow and nf-core on the nf-core [website](https://nf-co.re/) . Pipeline-specific documentation is bundled with each pipeline in the /docs folder. This can be read either locally, on GitHub, or on the nf-core website.

Each pipeline has its own webpage at https://nf-co.re/<pipeline_name> e.g. [nf-co.re/rnaseq](https://nf-co.re/rnaseq/usage)

In addition to this documentation, each pipeline comes with basic command line reference. This can be seen by running the pipeline with the `--help` flag, for example:

~~~
nextflow run nf-core/rnaseq --help
~~~
{: .language-bash}

~~~
N E X T F L O W  ~  version 20.10.0
Launching `nf-core/rnaseq` [silly_miescher] - revision: 3643a94411 [3.0]
------------------------------------------------------
                                        ,--./,-.
        ___     __   __   __   ___     /,-._.--~'
  |\ | |__  __ /  ` /  \ |__) |__         }  {
  | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                        `._,._,'
  nf-core/rnaseq v3.0
------------------------------------------------------

Typical pipeline command:

    nextflow run nf-core/rnaseq --input samplesheet.csv --genome GRCh37 -profile docker

Input/output options
    --input                             [string]  Path to comma-separated file containing information about the samples in the experiment.
    --outdir                            [string]  Path to the output directory where the results will be saved.
    --public_data_ids                   [string]  File containing SRA/ENA/GEO identifiers one per line in order to download their associated FastQ files.
    --email                             [string]  Email address for completion summary.
    --multiqc_title                     [string]  MultiQC report title. Printed as page header, used for filename if not otherwise specified.
    --skip_sra_fastq_download           [boolean] Only download metadata for public data database ids and don't download the FastQ files.
    --save_merged_fastq                 [boolean] Save FastQ files after merging re-sequenced libraries in the results directory.
..truncated..
~~~
{: .output}

## The nf-core launch command

As can be seen from the output of the help option nf-core pipelines have a number of flags that need to be passed on the command line: some mandatory, some optional.

To make it easier to launch pipelines, these parameters are described in a JSON file, `nextflow_schema.json` bundled with the pipeline.

The `nf-core launch` command uses this to build an interactive command-line wizard which walks through the different options with descriptions of each, showing the default value and prompting for values.

Once all prompts have been answered, non-default values are saved to a `params.json` file which can be supplied to Nextflow to run the pipeline. Optionally, the Nextflow command can be launched there and then.

To use the launch feature, just specify the pipeline name:

~~~
nf-core launch rnaseq
~~~
{: .language-bash}

> ## Exercise : nf-core launch rnaseq
>
>  Use the launch feature to create a `nf-params.json` file.
>
> Use the `command line launch option`
>
> add an input file name `samples.csv`
>
> add a genome `GRCh38`
>
> **Do not run the command now**
> > ## Solution
> >
> > {: .solution}
> > The contents of the nf-params.json file should be
> > ~~~
> > {
> >   "input": "samples.csv",
> >   "genome": "GRCh38"
> > }
> > ~~~
> {: .solution}
{: .challenge}


## Config files

nf-core pipelines make use of Nextflow's configuration files to specify how the pipelines execution, define custom parameters and what software management system to use e.g. docker, singularity or conda.

Nextflow can load pipeline configurations from multiple locations.  nf-core pipelines load configuration in the following order:

![config](../fig/nfcore_config.png)

1. Pipeline: Default 'base' config
* Always loaded. Contains pipeline-specific parameters and "sensible defaults" for things like computational requirements
* Does not specify any method for software packaging. If nothing else is specified, Nextflow will expect all software to be available on the command line.
2. Core config profiles
* All nf-core pipelines come with some generic config profiles. The most commonly used ones are for software packaging: docker, singularity and conda
* Other core profiles are debug and two test profiles. There two test profile, a small test profile (nf-core/test-datasets) for quick test and a full test profile which provides the path to full sized data from public repositories.
3. Server profiles
* At run time, nf-core pipelines fetch configuration profiles from the [configs remote repository](https://github.com/nf-core/configs). The profiles here are specific to clusters at different institutions.
* Because this is loaded at run time, anyone can add a profile here for their system and it will be immediately available for all nf-core pipelines.
4. Local config files given to Nextflow with the `-c` flag
* `nextflow run nf-core/rnaseq -c mylocal.config`
5. Command line configuration: pipeline parameters can be passed on the command line using the `--<parameter>` syntax.
*  `nextflow run nf-core/rnaseq --email "my@email.com"`


### Config Profiles

To make it easy to apply a group of options on the command line, Nextflow uses the concept of `config profiles` which are like aliases for configs.

Configuration files can contain the definition of one or more profiles. A profile is a set of configuration attributes that can be activated/chosen when launching a pipeline execution by using the `-profile` command line option. Common profiles are conda, singularity and docker that specify which software manager to use.

Below is an example portion of the `$HOME/.nextflow/assets/nf-core/rnaseq/nextflow.config` showing some profiles.

~~~
profiles {
  debug       {
    process.beforeScript = 'echo $HOSTNAME'
  }
  conda       {
    params.enable_conda = true
  }
  docker      {
    docker.enabled = true
    docker.runOptions = '-u \$(id -u):\$(id -g)'
  }
  singularity {
    singularity.enabled = true
    singularity.autoMounts = true
  }
  podman {
    podman.enabled = true
  }
  test        {
    includeConfig 'conf/test.config'      
  }

}
~~~

Multiple comma-separate config profiles can be specified in one go, so the following commands are perfectly valid:

~~~
nextflow run nf-core/rnaseq -profile test,docker
nextflow run nf-core/rnaseq -profile singularity,debug
~~~
{: .language-bash}

Note that the order in which config profiles are specified matters. Their priority increases from left to right.

> ## Multiple Nextflow configuration locations
>  Be clever with multiple Nextflow configuration locations. For example, use `-profile` for your cluster  configuration, the file `$HOME/.nextflow/config` for your personal config such as `params.email` and a working directory >`nextflow.config` file for reproducible run-specific configuration.
{: .callout}

> ## Exercise  create a custom config
> Add the `params.email` to a file called `custom.config`
> > ## Solution
> > A line similar to one below in the file custom.config
> > ~~~
> > params.email = "myemail@address.com"
> > ~~~
> {: .solution}
{: .challenge}


# Running pipelines with test data


The test config profile `test` is a bit of a special case. Whereas all other config profiles tell Nextflow how to run on different computational systems, the test profile configures each nf-core pipeline to run without any other command line flags. It specifies URLs for test data and all required parameters. Because of this, you can test any nf-core pipeline with the following command:

~~~
nextflow run nf-core/<pipeline_name> -profile test
~~~
{: .language-bash}

> ## Software configuration profile
> Note that you will typically still need to combine this with a software configuration profile for your system - e.g.
> `-profile test,docker`.
> Running with the test profile is a great way to confirm that you have
> Nextflow configured properly for your system before attempting to run with real data
{: .callout}

## Using nf-core pipelines offline

Many of the techniques and resources described above require an active internet connection at run time - pipeline files, configuration profiles and software containers are all dynamically fetched when the pipeline is launched. This can be a problem for people using secure computing resources that do not have connections to the internet.

To help with this, the `nf-core download` command automates the fetching of required files for running nf-core pipelines offline.
The command can download a specific release of a pipeline with `-r`/`--release` .  
By default, the pipeline will download the pipeline code and the institutional nf-core/configs files.

If you specify the flag `--singularity`, it will also download any singularity image files that are required (this needs Singularity to be installed). All files are saved to a single directory, ready to be transferred to the cluster where the pipeline will be executed.


~~~
nf-core download nf-core/rnaseq -r 3.0
~~~
> {: .language-bash}

~~~

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 1.13.1
    There is a new version of nf-core/tools available! (1.13.2)



INFO     Saving nf-core/rnaseq                                                                                                                                                                                                                                         download.py:148
          Pipeline release: '3.0'
          Pull singularity containers: 'No'
          Output file: 'nf-core-rnaseq-3.0.tar.gz'
INFO     Downloading workflow files from GitHub                                                                                                                                                                                                                        download.py:151
INFO     Downloading centralised configs from GitHub                                                                                                                                                                                                                   download.py:155
INFO     Compressing download..                                                                                                                                                                                                                                        download.py:166
INFO     Command to extract files: tar -xzf nf-core-rnaseq-3.0.tar.gz                                                                                                                                                                                                  download.py:653
INFO     MD5 checksum for nf-core-rnaseq-3.0.tar.gz: f0e0c239bdb39c613d6a080f1dee88e9
~~~
{: .output}

> ## Exercise  Running a test pipeline
>
>  Run the nf-core/rnaseq pipeline with the provided test data using the test profile
> > ## Solution
> >
> > ~~~
> > nextflow run nf-core/rnaseq -r 3.0 -profile test
> > ~~~
> {: .solution}
{: .challenge}


## Troubleshooting


If you run into issues running your pipeline you can you the nf-core  website  to troubleshoot common mistakes and issues [https://nf-co.re/usage/troubleshooting](https://nf-co.re/usage/troubleshooting) .

### Extra resources and getting help


If you still have an issue with running the pipeline then feel free to contact the nf-core community via the Slack channel .
The nf-core Slack organisation has channels dedicated for each pipeline, as well as specific topics (eg. `#help`, `#pipelines`, `#tools`, `#configs` and much more).
The nf-core Slack can be found at https://nfcore.slack.com (NB: no hyphen in nfcore!). To join you will need an invite, which you can get at https://nf-co.re/join/slack.

You can also get help by opening an issue in the respective pipeline repository on GitHub asking for help.

If you have problems that are directly related to Nextflow and not our pipelines or the nf-core framework tools then check out the [Nextflow gitter channel](https://gitter.im/nextflow-io/nextflow) or the [google group](https://groups.google.com/forum/#!forum/nextflow).


## Restarting Pipelines

Once you have fixed your issue you can restart a pipeline using the Nextflow `-resume` option. This will resume the last pipeline run. You can use the `nextflow log` command to find names of all previous runs in your directory. These can be used with `-resume` to restart specific runs.

~~~
nextflow log
~~~
> {: .language-bash}

~~~
nextflow run nf-core/rnaseq -r 1.3 -profile test -resume <run_name>
~~~
> {: .language-bash}

> ## Citation
> If you use nf-core tools in your work, please cite the nf-core publication as follows:
>
> **The nf-core framework for community-curated bioinformatics pipelines.**
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
> Nat Biotechnol. 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x). ReadCube: [Full Access Link](https://rdcu.be/b1GjZ)
>
{: .callout}

{: .language-bash}

{% include links.md %}