// 关卡数据配置

import { Level } from '../models/Level';
import { Piece, PieceType } from '../models/Piece';
import { PieceColors } from '../constants/GameConstants';

// 关卡数据数组
export const LEVELS: Level[] = [
  // 关卡1: 横刀立马(简单)
  {
    id: 1,
    name: '横刀立马',
    difficulty: '简单',
    pieces: [
      // 曹操(2x2) - 顶部中央
      {
        id: 'caocao',
        name: '曹操',
        type: PieceType.CAOCAO,
        position: { row: 0, col: 1 },
        size: { width: 2, height: 2 },
        color: PieceColors.CAOCAO
      },
      // 武将1(竖向1x2)
      {
        id: 'general1',
        name: '关羽',
        type: PieceType.GENERAL,
        position: { row: 0, col: 0 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将2(竖向1x2)
      {
        id: 'general2',
        name: '张飞',
        type: PieceType.GENERAL,
        position: { row: 0, col: 3 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将3(横向2x1)
      {
        id: 'general3',
        name: '赵云',
        type: PieceType.GENERAL,
        position: { row: 2, col: 0 },
        size: { width: 2, height: 1 },
        color: PieceColors.GENERAL
      },
      // 武将4(横向2x1)
      {
        id: 'general4',
        name: '马超',
        type: PieceType.GENERAL,
        position: { row: 2, col: 2 },
        size: { width: 2, height: 1 },
        color: PieceColors.GENERAL
      },
      // 兵卒1(1x1)
      {
        id: 'soldier1',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 0 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒2(1x1)
      {
        id: 'soldier2',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 1 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒3(1x1)
      {
        id: 'soldier3',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 2 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒4(1x1)
      {
        id: 'soldier4',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 3 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      }
    ]
  },
  
  // 关卡2: 指挥若定(中等)
  {
    id: 2,
    name: '指挥若定',
    difficulty: '中等',
    pieces: [
      // 曹操(2x2)
      {
        id: 'caocao',
        name: '曹操',
        type: PieceType.CAOCAO,
        position: { row: 0, col: 0 },
        size: { width: 2, height: 2 },
        color: PieceColors.CAOCAO
      },
      // 武将1(竖向1x2)
      {
        id: 'general1',
        name: '关羽',
        type: PieceType.GENERAL,
        position: { row: 0, col: 2 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将2(竖向1x2)
      {
        id: 'general2',
        name: '张飞',
        type: PieceType.GENERAL,
        position: { row: 0, col: 3 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将3(竖向1x2)
      {
        id: 'general3',
        name: '赵云',
        type: PieceType.GENERAL,
        position: { row: 2, col: 0 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将4(横向2x1)
      {
        id: 'general4',
        name: '马超',
        type: PieceType.GENERAL,
        position: { row: 2, col: 1 },
        size: { width: 2, height: 1 },
        color: PieceColors.GENERAL
      },
      // 兵卒1(1x1)
      {
        id: 'soldier1',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 2, col: 3 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒2(1x1)
      {
        id: 'soldier2',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 1 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒3(1x1)
      {
        id: 'soldier3',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 2 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒4(1x1)
      {
        id: 'soldier4',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 3 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      }
    ]
  },
  
  // 关卡3: 兵分三路(困难)
  {
    id: 3,
    name: '兵分三路',
    difficulty: '困难',
    pieces: [
      // 曹操(2x2)
      {
        id: 'caocao',
        name: '曹操',
        type: PieceType.CAOCAO,
        position: { row: 0, col: 1 },
        size: { width: 2, height: 2 },
        color: PieceColors.CAOCAO
      },
      // 武将1(竖向1x2)
      {
        id: 'general1',
        name: '关羽',
        type: PieceType.GENERAL,
        position: { row: 0, col: 0 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将2(竖向1x2)
      {
        id: 'general2',
        name: '张飞',
        type: PieceType.GENERAL,
        position: { row: 2, col: 0 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将3(竖向1x2)
      {
        id: 'general3',
        name: '赵云',
        type: PieceType.GENERAL,
        position: { row: 2, col: 3 },
        size: { width: 1, height: 2 },
        color: PieceColors.GENERAL
      },
      // 武将4(横向2x1)
      {
        id: 'general4',
        name: '马超',
        type: PieceType.GENERAL,
        position: { row: 2, col: 1 },
        size: { width: 2, height: 1 },
        color: PieceColors.GENERAL
      },
      // 兵卒1(1x1)
      {
        id: 'soldier1',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 0, col: 3 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒2(1x1)
      {
        id: 'soldier2',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 1, col: 3 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒3(1x1)
      {
        id: 'soldier3',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 1 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      },
      // 兵卒4(1x1)
      {
        id: 'soldier4',
        name: '兵',
        type: PieceType.SOLDIER,
        position: { row: 3, col: 2 },
        size: { width: 1, height: 1 },
        color: PieceColors.SOLDIER
      }
    ]
  }
];
