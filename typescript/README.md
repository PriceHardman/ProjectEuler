# ProjectEuler in TypeScript

Goal is to have each problem run in under 1s (ideally far less than that in most cases).


### Install a dev dependency
```sh
npm install <package-name> --save-dev
# or alternately npm i <package-name> -D
```

### Run test suite
```sh
npm test
```

### Run benchmark suite
```sh
npm run benchmark
```

### Run a single arbitrary snippet of code
```sh
npx ts-node -e "import { problem001 } from './src/problem_001'; console.log(problem001())"
```

### Quick and dirty benchmark of a single function using `time`
```sh
time npx ts-node -e "import * as p from './src/problems/problem_014'; console.log(p.main())"
```
Output:
>npx ts-node -e   1.34s user 0.14s system 140% cpu 1.059 total



