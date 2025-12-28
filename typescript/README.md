# ProjectEuler in TypeScript

Goal is to have each problem run in under 1s (ideally far less than that in most cases).


### Install a dev dependency
```
npm install <package-name> --save-dev
# or alternately npm i <package-name> -D
```

### Run tests
```
npm test
```

### Run benchmarks
```aiignore
npm run benchmark
```

### Run a single arbitrary snippet of code
```
npx ts-node -e "import { problem001 } from './src/problem_001'; console.log(problem001())"
```



