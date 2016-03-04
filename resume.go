package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"

	"github.com/Sirupsen/logrus"
	"github.com/russross/blackfriday"
)

var Output string

func main() {
	if _, err := os.Stat("./source"); os.IsNotExist(err) {
		fmt.Println("`source` directory was not found, check you are in the project root")
	}
	if _, err := os.Stat("./output"); os.IsNotExist(err) {
		fmt.Println("`output` directory was not found, check you are in the project root")
	}

	Output = Output + `<!DOCTYPE html><html><head><meta charset="utf-8" /><link rel="stylesheet" href="media/base.css" /></head><body>`

	roamDirectory("./source")

	ioutil.WriteFile("./output/resume.html", []byte(Output), 0644)

	wk := exec.Command("wkhtmltopdf", "-T", "10mm", "-R", "10mm", "-B", "10mm", "-L", "10mm", "./output/resume.html", "./output/resume.pdf")
	wk.Run()
}

func roamDirectory(p string) {
	chunks, err := filepath.Glob(p + "/*")
	if err != nil {
		logrus.Fatalf("could not find source path: %s", err)
	}

	for _, ch := range chunks {
		st, err := os.Stat(ch)
		if err != nil {
			logrus.Errorf("skipping %s: %s", ch, err)
		}

		if st.IsDir() {
			divize(ch, roamDirectory)
			continue
		}

		divize(ch, markdown)
	}
}

func markdown(s string) {
	b, err := ioutil.ReadFile(s)
	if err != nil {
		logrus.Errorf("skipping %s: %s", s, err)
	}

	Output = Output + string(blackfriday.MarkdownCommon(b))
}

func divize(f string, fn func(string)) {
	classes := strings.Join(strings.Split(strings.Split(path.Base(f), ".")[0], "-")[1:], " ")
	div := fmt.Sprintf(`<div class="section %s">`, classes)

	Output = Output + div
	if fn != nil {
		fn(f)
	}
	Output = Output + "</div>"
}
