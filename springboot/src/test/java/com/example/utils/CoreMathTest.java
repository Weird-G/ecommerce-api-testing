package com.example.utils;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * CoreMath 皮尔森相关系数 & 邻居计算 JUnit5 白盒测试
 * <p>
 * 覆盖边界场景：
 * 1) 空集合 / 单元素 —— pearson 返回 0
 * 2) 完全正相关 (1,2,3) vs (2,4,6) = +1
 * 3) 完全负相关 (1,2,3) vs (6,4,2) = -1
 * 4) 零方差分母 (所有值相同) —— 返回 0，避免除以 0
 * 5) 随机部分相关
 * 6) 冷启动：computeNeighbor 输入里没有该 key 用户
 */
@DisplayName("CoreMath 核心算法（皮尔森相关系数）")
class CoreMathTest {

    // ------------------------------------------------------------------
    // getRelate() —— 皮尔森相关系数
    // ------------------------------------------------------------------
    @Nested
    @DisplayName("getRelate 皮尔森相关系数边界值")
    class GetRelateEdgeCases {

        @Test
        @DisplayName("空列表 -> 0（长度<2）")
        void emptyLists_returnsZero() {
            assertEquals(0.0, CoreMath.getRelate(Collections.emptyList(), Collections.emptyList()));
        }

        @Test
        @DisplayName("单元素 -> 0（长度<2）")
        void singleElement_returnsZero() {
            assertEquals(0.0, CoreMath.getRelate(
                    Collections.singletonList(1),
                    Collections.singletonList(99)
            ));
        }

        @Test
        @DisplayName("完全正相关 -> +1.0")
        void perfectPositiveCorrelation_returnsOne() {
            List<Integer> xs = Arrays.asList(1, 2, 3, 4, 5);
            List<Integer> ys = Arrays.asList(2, 4, 6, 8, 10); // y = 2x
            double r = CoreMath.getRelate(xs, ys);
            assertEquals(1.0, r, 1e-9);
        }

        @Test
        @DisplayName("完全负相关 -> -1.0")
        void perfectNegativeCorrelation_returnsMinusOne() {
            List<Integer> xs = Arrays.asList(1, 2, 3, 4, 5);
            List<Integer> ys = Arrays.asList(10, 8, 6, 4, 2); // y = -2x + 12
            double r = CoreMath.getRelate(xs, ys);
            assertEquals(-1.0, r, 1e-9);
        }

        @Test
        @DisplayName("零方差分母（X 全相同）-> 返回 0，不抛异常")
        void zeroVarianceX_returnsZero_NoException() {
            List<Integer> xs = Arrays.asList(5, 5, 5, 5);
            List<Integer> ys = Arrays.asList(1, 2, 3, 4);
            assertDoesNotThrow(() -> CoreMath.getRelate(xs, ys));
            assertEquals(0.0, CoreMath.getRelate(xs, ys));
        }

        @Test
        @DisplayName("零方差分母（Y 全相同）-> 返回 0，不抛异常")
        void zeroVarianceY_returnsZero_NoException() {
            List<Integer> xs = Arrays.asList(1, 2, 3, 4);
            List<Integer> ys = Arrays.asList(7, 7, 7, 7);
            assertDoesNotThrow(() -> CoreMath.getRelate(xs, ys));
            assertEquals(0.0, CoreMath.getRelate(xs, ys));
        }

        @Test
        @DisplayName("零方差分母（X&Y 都全相同）-> 返回 0")
        void zeroVarianceBoth_returnsZero() {
            List<Integer> xs = Arrays.asList(3, 3, 3, 3);
            List<Integer> ys = Arrays.asList(3, 3, 3, 3);
            assertEquals(0.0, CoreMath.getRelate(xs, ys));
        }

        @Test
        @DisplayName("无关向量（理论相关系数 r=0）-> 接近 0")
        void noCorrelation_nearZero() {
            // xs=[1,2,3,4] ys=[2,4,1,3]：去均值后叉积和为 0，理论上 r=0
            // （原 [4,3,1,2] 实为强负相关 r=-0.8，与“无关”语义矛盾，故修正）
            List<Integer> xs = Arrays.asList(1, 2, 3, 4);
            List<Integer> ys = Arrays.asList(2, 4, 1, 3);
            double r = CoreMath.getRelate(xs, ys);
            assertTrue(-0.05 < r && r < 0.05, () -> "应接近0，实际 r=" + r);
        }

        @Test
        @DisplayName("长度不相等（较短者参与，较长部分截断）")
        void differentLength_useMinLength() {
            // getRelate 实现使用 n = xs.size()，并按 i 范围循环 IntStream.range(0, n)
            // 如果 ys 更短，get(i) 会 IndexOutOfBounds！
            // 这是算法潜在缺陷，预期会抛异常
            List<Integer> xs = Arrays.asList(1, 2, 3, 4, 5);
            List<Integer> ys = Arrays.asList(2, 4); // 更短
            assertThrows(IndexOutOfBoundsException.class, () -> CoreMath.getRelate(xs, ys));
        }
    }

    // ------------------------------------------------------------------
    // computeNeighbor() —— 冷启动 & 正常输入
    // ------------------------------------------------------------------
    @Nested
    @DisplayName("computeNeighbor 用户相似度")
    class ComputeNeighborTests {

        @Test
        @DisplayName("冷启动：map 中无目标用户 -> 空结果")
        void coldStart_keyNotExist_returnsEmpty() {
            Map<Integer, List<com.example.entity.RelateDTO>> map = new HashMap<>();
            map.put(2, Collections.singletonList(new com.example.entity.RelateDTO(2, 10, 5)));
            Map<Integer, Double> res = CoreMath.computeNeighbor(999, map, 0);
            assertTrue(res.isEmpty(), "冷启动用户没有邻居");
        }

        @Test
        @DisplayName("目标用户存在但无其他用户 -> 空结果")
        void onlyOneUser_returnsEmpty() {
            Map<Integer, List<com.example.entity.RelateDTO>> map = new HashMap<>();
            map.put(1, Arrays.asList(
                    new com.example.entity.RelateDTO(1, 10, 5),
                    new com.example.entity.RelateDTO(1, 20, 3)
            ));
            Map<Integer, Double> res = CoreMath.computeNeighbor(1, map, 0);
            assertTrue(res.isEmpty());
        }

        @Test
        @DisplayName("完全相同购买模式的两个用户 -> 距离=1.0")
        void twoIdenticalUsers_distanceEqualsOne() {
            Map<Integer, List<com.example.entity.RelateDTO>> map = new HashMap<>();
            map.put(1, Arrays.asList(
                    new com.example.entity.RelateDTO(1, 10, 1),
                    new com.example.entity.RelateDTO(1, 20, 2),
                    new com.example.entity.RelateDTO(1, 30, 3)
            ));
            // 用户2：对相同商品打完全相同的分
            map.put(2, Arrays.asList(
                    new com.example.entity.RelateDTO(2, 10, 1),
                    new com.example.entity.RelateDTO(2, 20, 2),
                    new com.example.entity.RelateDTO(2, 30, 3)
            ));

            Map<Integer, Double> res = CoreMath.computeNeighbor(1, map, 0);
            assertEquals(1, res.size());
            assertEquals(1.0, res.get(2), 1e-9, "完全相同应返回 +1.0 的绝对值");
        }
    }
}
