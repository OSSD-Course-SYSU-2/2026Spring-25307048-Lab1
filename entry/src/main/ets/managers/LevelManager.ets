// 关卡管理器

import { Level } from '../models/Level';
import { LEVELS } from '../data/LevelData';

// 关卡管理器类
export class LevelManager {
  // 获取所有关卡
  static getAllLevels(): Level[] {
    return LEVELS;
  }
  
  // 获取指定关卡
  static getLevel(levelId: number): Level | undefined {
    return LEVELS.find(level => level.id === levelId);
  }
  
  // 获取关卡数量
  static getLevelCount(): number {
    return LEVELS.length;
  }
}
