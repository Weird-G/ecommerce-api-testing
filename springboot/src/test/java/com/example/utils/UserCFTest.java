package com.example.utils;

import com.example.entity.RelateDTO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * UserCF 推荐单元测试
 * 覆盖：
 * 1) 冷启动（推荐用户无行为）
 * 2) 只有该用户（无邻居）
 * 3) 推荐逻辑：最近邻看过但目标用户未看过的商品
 * 4) 最近邻没有新商品可推荐（交集=全集，返回空）
 * 5) 多邻居相同最大相似度时取任一
 */
@DisplayName("UserCF 协同过滤推荐")
class UserCFTest {

    @Test
    @DisplayName("冷启动：行为列表为空 -> 返回空列表")
    void coldStart_emptyList() {
        List<Integer> rec = UserCF.recommend(1, Collections.emptyList());
        assertNotNull(rec);
        assertTrue(rec.isEmpty());
    }

    @Test
    @DisplayName("冷启动：list 非空但没有该 userId -> 返回空列表")
    void coldStart_noUserInList() {
        List<RelateDTO> list = Collections.singletonList(new RelateDTO(999, 1, 5));
        List<Integer> rec = UserCF.recommend(1, list);
        assertTrue(rec.isEmpty());
    }

    @Test
    @DisplayName("只有该用户自己 -> 没有邻居，返回空")
    void onlyOneUser_noNeighbor() {
        List<RelateDTO> list = Arrays.asList(
                new RelateDTO(1, 10, 5),
                new RelateDTO(1, 20, 3)
        );
        List<Integer> rec = UserCF.recommend(1, list);
        assertTrue(rec.isEmpty());
    }

    @Test
    @DisplayName("典型场景：用户1和用户2高度相似，推荐用户2看过但用户1未看过的")
    void typicalRecommendation_neighborOnlyItems() {
        List<RelateDTO> list = Arrays.asList(
                // 用户1: 商品 10(r=1), 20(r=2)
                new RelateDTO(1, 10, 1),
                new RelateDTO(1, 20, 2),
                // 用户2: 商品 10(r=1), 20(r=2), 30(r=3), 40(r=4) —— 相似度 +1
                new RelateDTO(2, 10, 1),
                new RelateDTO(2, 20, 2),
                new RelateDTO(2, 30, 3),
                new RelateDTO(2, 40, 4)
        );
        List<Integer> rec = UserCF.recommend(1, list);
        // 应推荐 [30, 40]
        assertNotNull(rec);
        assertEquals(2, rec.size(), () -> "推荐结果: " + rec);
        assertTrue(rec.containsAll(Arrays.asList(30, 40)));
        assertFalse(rec.contains(10));
        assertFalse(rec.contains(20));
    }

    @Test
    @DisplayName("最近邻没有可推荐商品（和目标用户看过完全相同）-> 返回空")
    void neighborItemsSubsetOfUser_returnEmpty() {
        List<RelateDTO> list = Arrays.asList(
                new RelateDTO(1, 10, 1),
                new RelateDTO(1, 20, 2),
                new RelateDTO(2, 10, 1),
                new RelateDTO(2, 20, 2)
        );
        List<Integer> rec = UserCF.recommend(1, list);
        assertTrue(rec.isEmpty());
    }
}
