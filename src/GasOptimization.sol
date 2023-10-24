// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract GasOptimization {
    uint256 public total;

    // 对内存地址的引用，不管是读、写还是其它操作（比如CALL）只要超过了当前内存的长度，就会带来额外 gas 消耗。在接口中使用 calldata 能减少内存扩展。
    function sumIfEvenAndLessThan107(uint[] calldata input) external {
        // 循环内高频写入的状态变量拷贝到内存中。
        uint256 _total = 0;
        // 数组长度input.length 与数组循环变量 input[i]每次循环都会读，而且是从参数中读，可以拷贝到内存当中更加节约 Gas。将数组元素加载到内存.
        uint256 len = input.length;
        // 循环自增变量 i 优化
        for (uint256 i = 0; i < len; ++i) {
            // 每次循环都会声明isEven、isLessThanThreshold 变量，而声明内存变量是要计算 gas 的。
            // 这些变量只是用来做一次条件判断，明显是可以合并起来，减少内部声明的变量。
            // 但是可读性要差一些，所以修改了函数名字使得函数体更加清晰。
            uint256 num = input[i];
            if (num % 2 == 0 && num < 107) {
                _total += input[i];
            }
        }
        total = _total;
    }
}
